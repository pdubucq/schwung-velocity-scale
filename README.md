# Velocity Scale

A MIDI FX for [Schwung](https://github.com/charlesvestal/schwung): scales and
curves incoming note velocities.

- **Min / Max** — the output range. A flat pad becomes a narrow band.
- **Curve** — −100 to +100. Negative softens, positive hardens.
- **Curve Preset** — Linear, Soft, Softer, Hard, Harder.

## Why it is not bundled any more

It shipped inside the host up to v0.2.0. It is a catalog module from v0.3.0, so
it can be updated without a host release — and so the host tarball carries only
what a device genuinely cannot start without.

Installing it over a bundled copy is an UPDATE, not a downgrade: 0.3.0 is
deliberately above the 0.2.0 that shipped in the bundle.

## Build

    ./scripts/build.sh    # -> dist/velocity_scale-module.tar.gz
