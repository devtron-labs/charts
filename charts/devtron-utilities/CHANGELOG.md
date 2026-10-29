# Changelog — devtron-utilities

> **Baseline note.** This chart was previously managed outside git (downloaded from the
> Devtron chart store, modified, repackaged, re-uploaded). This repo was stale at `0.0.4`;
> releases `0.0.5`–`0.0.9` were never committed. Starting at `0.0.10` this repo is the
> source of truth, and this changelog begins there.

---

# Changelog: devtron-utilities 0.0.9 → 0.0.10

## Summary

The only functional change between these two releases is an upgrade of the bundled
**Karpenter** sub-chart from **1.10.0 → 1.13.0** (the Karpenter controller image, CRDs,
RBAC, templates and values all move with it). No other sub-chart was touched.

> **Note on versions:** In `0.0.9` the top-level `Chart.yaml` pinned Karpenter to
> `1.10.0` while `Chart.lock` still recorded `1.8.1` (a pre-existing inconsistency).
> `0.0.10` aligns both to `1.13.0`.

---

## Chart metadata

| Item | 0.0.9 | 0.0.10 |
|------|-------|--------|
| Umbrella chart version | `0.0.9` | `0.0.10` |
| Karpenter dependency (`Chart.yaml`) | `1.10.0` | `1.13.0` |
| Karpenter resolved (`Chart.lock`) | `1.8.1` | `1.13.0` |
| Karpenter `appVersion` / `version` | `1.10.0` | `1.13.0` |
| Karpenter controller image tag | `1.10.0` | `1.13.0` |
| Controller image digest | `sha256:0c21513…c001a3` | `sha256:ea731b0…279b7fe` |

---

## Karpenter 1.10.0 → 1.13.0

### New configurable settings (`charts/karpenter/values.yaml`)

| Setting | Default | Purpose |
|---------|---------|---------|
| `settings.enableZonalShift` | `false` | Signals Karpenter to respect [AWS EKS Zonal Shift](https://docs.aws.amazon.com/eks/latest/userguide/zone-shift-enable.html) when making node claims. |
| `settings.amiRefreshInterval` | `1m` | How often Karpenter refreshes AMI data from EC2 (trades API calls against discovery/drift staleness; min `1m`). |
| `settings.subnetRefreshInterval` | `1m` | How often Karpenter refreshes subnet data from EC2 (trades `DescribeSubnets` calls against staleness; min `1m`). |
| `settings.featureGates.capacityBuffer` | `false` | **ALPHA** feature gate — enables CapacityBuffer support for pre-provisioning spare capacity. |
| `serviceMonitor.sampleLimit` | `null` | Per-scrape limit on accepted Prometheus samples; `0` = no limit, `null` = unset. |

### Template changes

- **`deployment.yaml`** — wires the new settings into controller env vars:
  - Feature-gate string now appends `CapacityBuffer={{ ... }}`.
  - New conditional env vars: `ENABLE_ZONAL_SHIFT`, `AMI_REFRESH_INTERVAL`, `SUBNET_REFRESH_INTERVAL`.
- **`servicemonitor.yaml`** — emits a `sampleLimit` field when `serviceMonitor.sampleLimit` is set.
- **`clusterrole-core.yaml`** — RBAC expanded:
  - New read access (`get/list/watch`) on `autoscaling.x-k8s.io` `capacitybuffers` + `capacitybuffers/status`.
  - New read access on core `podtemplates`.
  - New write access (`update/patch`) on `capacitybuffers/status`.
  - A `list,watch` grant tightened to `get,list,watch` and a malformed `list` literal fixed.

### CRD changes (generated via newer controller-gen)

CRDs were regenerated with newer `controller-gen` versions (ec2nodeclasses on `v0.21.0`;
nodeclaims/nodeoverlays/nodepools on `v0.20.1`, up from `v0.19.0`). Notable additions:

- **`ec2nodeclasses`**
  - New AMI family **`windows2025`** added to the supported families and validation rules.
  - New **`connectionTracking`** block (`tcpEstablishedTimeout`, `udpStreamTimeout`, `udpTimeout`) for idle connection-tracking timeouts on provisioned ENIs.
- **`nodeclaims` / `nodepools` / `nodeoverlays`**
  - Requirement operators extended: `Gt`/`Lt` now joined by **`Gte`** and **`Lte`**.
  - New well-known AWS labels allowed, including `karpenter.k8s.aws/instance-tenancy`, `capacity-reservation-interruptible`, `placement-group-id`, and `placement-group-partition`.
  - Various `x-kubernetes-list-type`/`list-map-keys`/`map-type` markers added, plus description/casing cleanups.
- **`nodepools`**
  - Consolidation policy documents a new valid value **`Balanced`** (alongside `WhenEmpty`, `WhenEmptyOrUnderutilized`).

### Documentation

- `charts/karpenter/README.md` regenerated for 1.13.0 (version badges, install/cosign-verify commands, and the values table reflecting all new settings above).

---

## ⚠️ Breaking changes

No hard breaking changes to this umbrella chart's defaults — all new Karpenter settings
are opt-in and default to their previous behaviour (`false` / `1m` / `null`). However,
review the following before upgrading:

1. **CRD upgrade is required.** Helm does **not** upgrade CRDs automatically on `helm upgrade`.
   You must apply the updated Karpenter CRDs (`ec2nodeclasses`, `nodeclaims`, `nodepools`,
   `nodeoverlays`) manually before/alongside the upgrade, or the new schema features
   (`connectionTracking`, `Gte`/`Lte` operators, `windows2025`, new labels) will not be available.
2. **Expanded RBAC.** The controller ClusterRole now requires access to `capacitybuffers`
   and core `podtemplates`. Restrictive admission/policy controllers (OPA/Kyverno, etc.)
   may need to allow these.
3. **Multi-version jump.** This bundles a 3-minor Karpenter jump (1.10 → 1.13; the lockfile
   effectively moves from 1.8.1). Review the upstream Karpenter release notes for 1.11, 1.12,
   and 1.13 for any controller-level behavioural changes and run a `helm diff` against a
   non-production cluster first.
