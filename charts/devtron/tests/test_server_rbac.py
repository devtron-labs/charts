"""Run after `helm dependency build charts/devtron` with Python's unittest."""

from pathlib import Path
import re
import subprocess
import unittest


CHART = Path(__file__).resolve().parents[1]


def render(template="rbac.yaml", *arguments, check=True):
    return subprocess.run(
        ["helm", "template", "devtron", str(CHART), "--namespace", "devtroncd",
         "--show-only", "templates/" + template, *arguments],
        capture_output=True, text=True, check=check,
    )


class ServerRbacTest(unittest.TestCase):
    def test_default_keeps_server_permissions(self):
        result = render().stdout
        self.assertEqual(re.findall(r"^kind: (.+)$", result, re.MULTILINE),
                         ["ServiceAccount", "ClusterRole", "ClusterRoleBinding"])
        self.assertEqual(result, render("rbac.yaml", "--set",
                                      "components.devtron.rbac.create=true").stdout)

    def test_disabled_keeps_service_account_only(self):
        result = render("rbac.yaml", "--set", "components.devtron.rbac.create=false").stdout
        self.assertEqual(re.findall(r"^kind: (.+)$", result, re.MULTILINE),
                         ["ServiceAccount"])
        self.assertIn("  name: devtron\n", result)
        self.assertIn("  namespace: devtroncd\n", result)

    def test_disabled_does_not_change_server_workload(self):
        self.assertEqual(render("devtron.yaml").stdout,
                         render("devtron.yaml", "--set",
                                "components.devtron.rbac.create=false").stdout)

    def test_string_false_is_rejected(self):
        result = render("rbac.yaml", "--set-string",
                        "components.devtron.rbac.create=false", check=False)
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("components.devtron.rbac.create must be a boolean", result.stderr)


if __name__ == "__main__":
    unittest.main()
