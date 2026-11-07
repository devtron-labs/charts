"""Check that optional RBAC ownership preserves component resources."""

import re
import unittest

from test_server_rbac import render


COMPONENTS = [
    ("install.yaml", "installer", 3),
    ("kubewatch.yaml", "components.kubewatch", 2),
    ("workflow.yaml", "workflowController", 9),
]
RBAC_KINDS = {"Role", "RoleBinding", "ClusterRole", "ClusterRoleBinding"}
CICD = ["--set", "installer.modules[0]=cicd"]


def documents(output):
    result = []
    for document in re.split(r"(?m)^---\s*$", output):
        match = re.search(r"(?m)^kind: (.+)$", document)
        if match:
            content = "\n".join(line for line in document.splitlines()
                                if line.strip() and not line.startswith("# Source:"))
            result.append((match[1], content))
    return result


class ComponentRbacTest(unittest.TestCase):
    def test_defaults_retain_each_components_roles(self):
        for template, component, expected in COMPONENTS:
            with self.subTest(component=component):
                default = render(template, *CICD).stdout
                explicit = render(template, *CICD, "--set", component + ".rbac.create=true").stdout
                self.assertEqual(default, explicit)
                self.assertEqual(sum(kind in RBAC_KINDS for kind, _ in documents(default)), expected)

    def test_disabled_removes_only_roles_and_bindings(self):
        for enterprise in ("false", "true"):
            for template, component, _ in COMPONENTS:
                with self.subTest(component=component, enterprise=enterprise):
                    options = [*CICD, "--set", "devtronEnterprise.enabled=" + enterprise]
                    before = documents(render(template, *options).stdout)
                    after = documents(render(template, *options, "--set",
                                             component + ".rbac.create=false").stdout)
                    self.assertTrue(any(kind in RBAC_KINDS for kind, _ in before))
                    self.assertFalse(any(kind in RBAC_KINDS for kind, _ in after))
                    self.assertEqual([item for item in before if item[0] not in RBAC_KINDS], after)

    def test_string_false_is_rejected_for_each_component(self):
        for template, component, _ in COMPONENTS:
            with self.subTest(component=component):
                result = render(template, *CICD, "--set-string",
                                component + ".rbac.create=false", check=False)
                self.assertNotEqual(result.returncode, 0)
                self.assertIn(component + ".rbac.create must be a boolean", result.stderr)

    def test_disabling_other_components_does_not_change_this_component(self):
        for template, component, _ in COMPONENTS:
            with self.subTest(component=component):
                options = [*CICD, "--set", "components.devtron.rbac.create=false"]
                for _, other, _ in COMPONENTS:
                    if other != component:
                        options.extend(["--set", other + ".rbac.create=false"])
                self.assertEqual(documents(render(template, *CICD).stdout),
                                 documents(render(template, *options).stdout))


if __name__ == "__main__":
    unittest.main()
