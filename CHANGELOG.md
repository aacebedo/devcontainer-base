# Changelog
All notable changes to this project will be documented in this file. See [conventional commits](https://www.conventionalcommits.org/) for commit guidelines.

- - -
## [v1.22.0](https://github.com/aacebedo/devcontainer-base/compare/17c2c0b9c6de45d4f2f9befb93fe2c9bcf38c017..v1.22.0) - 2026-09-13
#### Features
- add rtk - ([df0fc65](https://github.com/aacebedo/devcontainer-base/commit/df0fc653884869fd02afd659d8bed96d2bbdf50a)) - Alexandre ACEBEDO
#### Miscellaneous Chores
- (**ci**) switch back to rebase for mergify [skip ci] - ([17c2c0b](https://github.com/aacebedo/devcontainer-base/commit/17c2c0b9c6de45d4f2f9befb93fe2c9bcf38c017)) - Alexandre ACEBEDO

- - -

## [v1.21.1](https://github.com/aacebedo/devcontainer-base/compare/026a0cf18fbc3afde227805b3962a8f3eff499fa..v1.21.1) - 2026-09-09
#### Bug Fixes
- removed podman socket usage to build and test - ([02fee0b](https://github.com/aacebedo/devcontainer-base/commit/02fee0bde26bb6732fae2a233a15f5719e3a6bf3)) - Alexandre ACEBEDO
- fix dep bumping - ([8510a4d](https://github.com/aacebedo/devcontainer-base/commit/8510a4d83f48b48c990c2f29aeb7bad2f84f550d)) - Alexandre ACEBEDO
#### Miscellaneous Chores
- Update tombi in .mise/config.toml - ([026a0cf](https://github.com/aacebedo/devcontainer-base/commit/026a0cf18fbc3afde227805b3962a8f3eff499fa)) - github-actions[bot]

- - -

## [v1.21.0](https://github.com/aacebedo/devcontainer-base/compare/8db8d582b0907349cf270a644b86de6531b6975c..v1.21.0) - 2026-09-09
#### Features
- replace markdownlint-cli2 with rumdl - ([d176d95](https://github.com/aacebedo/devcontainer-base/commit/d176d951da9f44da92c8e12ebfefc4c4b950ab92)) - Alexandre ACEBEDO
- add missing updatecli files - ([6c62691](https://github.com/aacebedo/devcontainer-base/commit/6c62691ddeafce868cf2968fc661ddf46fd541f5)) - Alexandre ACEBEDO
- add trivy config files - ([1772e59](https://github.com/aacebedo/devcontainer-base/commit/1772e590ba28be78f399167389684802cef1a540)) - Alexandre ACEBEDO
- readd args to dockerfile - ([36a3c76](https://github.com/aacebedo/devcontainer-base/commit/36a3c76926f9374b03cee5a796dc58dcdebb8673)) - Alexandre ACEBEDO
#### Bug Fixes
- fix del key handling - ([5623f48](https://github.com/aacebedo/devcontainer-base/commit/5623f48943f88d97c8a33b1b0063c6a0ce72bbc3)) - Alexandre ACEBEDO
- fix trivy scan - ([08ffa30](https://github.com/aacebedo/devcontainer-base/commit/08ffa30b563070357d63be8624022891b5583542)) - Alexandre ACEBEDO
- make biome cli called in prek - ([7ed42bc](https://github.com/aacebedo/devcontainer-base/commit/7ed42bc29d211723a3b1d78b5b02adfddb1e196a)) - Alexandre ACEBEDO
- fixes small errors - ([8db8d58](https://github.com/aacebedo/devcontainer-base/commit/8db8d582b0907349cf270a644b86de6531b6975c)) - Alexandre ACEBEDO

- - -

## [v1.20.0](https://github.com/aacebedo/devcontainer-base/compare/8e126c56748bf59905df8a70278d4cf32c41d828..v1.20.0) - 2026-09-08
#### Features
- remode now useless nodejs - ([a0c160e](https://github.com/aacebedo/devcontainer-base/commit/a0c160e05294e6f7e08d2677dd539f3191af1ac0)) - Alexandre ACEBEDO
- switch from renovate to updatecli - ([4752006](https://github.com/aacebedo/devcontainer-base/commit/4752006c631b888148d5f2c7c1b87fe0288bc354)) - Alexandre ACEBEDO
- moved mise tasks - ([147df54](https://github.com/aacebedo/devcontainer-base/commit/147df54d99c75c6f6f0fd6cbba3ec80693e7228e)) - Alexandre ACEBEDO
- change formatting tooling - ([0b927bd](https://github.com/aacebedo/devcontainer-base/commit/0b927bd17b7fea16625e378e0004e56ef8c07d6b)) - Alexandre ACEBEDO
#### Bug Fixes
- sign automatic commits so they show as verified - ([4cb9c7a](https://github.com/aacebedo/devcontainer-base/commit/4cb9c7ac352b9fdc7579f6dba317ac2078586aff)) - Alexandre Acebedo
- fix actions - ([20085ff](https://github.com/aacebedo/devcontainer-base/commit/20085fff9265ff0b61a1673ac2b74dd6fbfe6866)) - Alexandre ACEBEDO
- change update-deps workflow to run on the host directly - ([3dbb24b](https://github.com/aacebedo/devcontainer-base/commit/3dbb24bea4c0b4184cfbfa900b1ef9404d5832c2)) - Alexandre ACEBEDO
- fix release workflow - ([2f117fc](https://github.com/aacebedo/devcontainer-base/commit/2f117fccbfaad277015dc87818b89f83d1b79a3f)) - Alexandre ACEBEDO
- remove copilot instruction files - ([09753bf](https://github.com/aacebedo/devcontainer-base/commit/09753bf4ccf1441d0c45131795af4e7ed226ad39)) - Alexandre ACEBEDO
- remove useless podman related packages - ([aad12eb](https://github.com/aacebedo/devcontainer-base/commit/aad12eb7907f937bddc09b4760c262b470aff295)) - Alexandre ACEBEDO
- switch to tombi - ([04f77cc](https://github.com/aacebedo/devcontainer-base/commit/04f77cc1fe18d1aa7330e9f9934140e2184775c6)) - Alexandre ACEBEDO
- update editorconfig-checker to github instead of aqua - ([8e126c5](https://github.com/aacebedo/devcontainer-base/commit/8e126c56748bf59905df8a70278d4cf32c41d828)) - Alexandre ACEBEDO
#### Miscellaneous Chores
- deps(github): bump Action tag for actions/checkout from v7 to ... - ([4dcbb0e](https://github.com/aacebedo/devcontainer-base/commit/4dcbb0eb289948fc640be867efab155918d4b763)) - github-actions[bot]
- deps: update Docker image "ubuntu" to "26.10" - ([65770c1](https://github.com/aacebedo/devcontainer-base/commit/65770c17133373ce0dff008b829f330aec4fac4f)) - github-actions[bot]
- deps(github): bump Action tag for actions/create-github-app-to... - ([12bf19f](https://github.com/aacebedo/devcontainer-base/commit/12bf19f2601fe45b1c5345eb9dc9edaa9dd951d5)) - github-actions[bot]
- deps(github): bump Action tag for github/codeql-action/upload-... - ([58e8b0f](https://github.com/aacebedo/devcontainer-base/commit/58e8b0f0c03f0bcd731a8e032e1019211a73a7b4)) - github-actions[bot]
- deps(github): bump Action tag for actions/checkout from v7 to ... - ([ac85fbd](https://github.com/aacebedo/devcontainer-base/commit/ac85fbd12ca1bc3100674add3600ebb5e6d5dc7b)) - github-actions[bot]
- deps(github): bump Action tag for actions/create-github-app-to... - ([17c86c3](https://github.com/aacebedo/devcontainer-base/commit/17c86c385a560273eb98de16d8a24b0dd3c7b251)) - github-actions[bot]
- deps(github): bump Action tag for actions/checkout from v7 to ... - ([937d0a0](https://github.com/aacebedo/devcontainer-base/commit/937d0a01398f55923ca7d524cffa37694e335f20)) - github-actions[bot]
- deps(github): bump Action tag for jdx/mise-action from v4 to v... - ([02ef497](https://github.com/aacebedo/devcontainer-base/commit/02ef497e02ad1bcbab561dddc9ba1f03de92372e)) - github-actions[bot]
- Update markdownlint-cli2 in .mise/config.toml - ([230166e](https://github.com/aacebedo/devcontainer-base/commit/230166e7637226f19266ec7fd0018c3f59692759)) - github-actions[bot]
- Update checkov in .mise/config.toml - ([d1997e5](https://github.com/aacebedo/devcontainer-base/commit/d1997e5401411d7483c801b5bcda5acee8cd73ba)) - github-actions[bot]
- Update dprint in .mise/config.toml - ([72a58c4](https://github.com/aacebedo/devcontainer-base/commit/72a58c4c2b58942543e777c83cf8d1c5abaea2d5)) - github-actions[bot]
- Update shfmt in .mise/config.toml - ([531c23b](https://github.com/aacebedo/devcontainer-base/commit/531c23b559d787041a43d198c19ae3817afa96c5)) - github-actions[bot]
- Update uv in .mise/config.toml - ([310fc51](https://github.com/aacebedo/devcontainer-base/commit/310fc518a20f156c8a5ceaf2f647981b6325c1d8)) - github-actions[bot]
- Update JJUI_VERSION in src/Dockerfile - ([91a923b](https://github.com/aacebedo/devcontainer-base/commit/91a923b420fa83db48f1209556f2f65753c7c8b0)) - github-actions[bot]
- Update mise version in .github/actions/setup/action.yml - ([3a0e321](https://github.com/aacebedo/devcontainer-base/commit/3a0e321b9448e0844c771895f60f237b8cf5a384)) - github-actions[bot]
- Update MISE_VERSION in src/Dockerfile - ([4119f73](https://github.com/aacebedo/devcontainer-base/commit/4119f73fc8f5d47b1838177426d21d9f9da7ead1)) - github-actions[bot]

- - -

## [v1.19.6](https://github.com/aacebedo/devcontainer-base/compare/bb2f2d6d58910d17a4915e557be647bb7effd53c..v1.19.6) - 2026-09-05
#### Bug Fixes
- fix missing mise file and completion - ([bb2f2d6](https://github.com/aacebedo/devcontainer-base/commit/bb2f2d6d58910d17a4915e557be647bb7effd53c)) - Alexandre ACEBEDO

- - -

## [v1.19.5](https://github.com/aacebedo/devcontainer-base/compare/bd704b2202e586cb20766013549a0d953030e3aa..v1.19.5) - 2026-09-04
#### Bug Fixes
- (**deps**) update dependency npm:renovate to v44.65.0 - ([bd704b2](https://github.com/aacebedo/devcontainer-base/commit/bd704b2202e586cb20766013549a0d953030e3aa)) - renovate[bot]

- - -

## [v1.19.4](https://github.com/aacebedo/devcontainer-base/compare/3c0953e6dbc92a56aa90c6c43d74f41c4de643c1..v1.19.4) - 2026-09-04
#### Bug Fixes
- (**deps**) update dependency github:rtk-ai/rtk to v0.48.0 - ([3c0953e](https://github.com/aacebedo/devcontainer-base/commit/3c0953e6dbc92a56aa90c6c43d74f41c4de643c1)) - renovate[bot]

- - -

## [v1.19.3](https://github.com/aacebedo/devcontainer-base/compare/07547079c6b67ee26f69fc17f13d8d400904f94e..v1.19.3) - 2026-09-04
#### Bug Fixes
- (**deps**) update dependency npm:renovate to v44.64.1 - ([0754707](https://github.com/aacebedo/devcontainer-base/commit/07547079c6b67ee26f69fc17f13d8d400904f94e)) - renovate[bot]

- - -

## [v1.19.2](https://github.com/aacebedo/devcontainer-base/compare/09207f3ce55e06ada02b1c8b4ea258a797943382..v1.19.2) - 2026-09-03
#### Bug Fixes
- (**deps**) update dependency github:rtk-ai/rtk to v0.47.0 - ([afbcd23](https://github.com/aacebedo/devcontainer-base/commit/afbcd23875a2b8c168ef1c71ebea837d4b629dd0)) - renovate[bot]
- (**deps**) update dependency shfmt to v3.14.0 - ([22c848b](https://github.com/aacebedo/devcontainer-base/commit/22c848b25dc34d403b18147a841aff1abf47792f)) - renovate[bot]
- (**deps**) update dependency jj-vcs/jj to v0.45.1 - ([f527fb7](https://github.com/aacebedo/devcontainer-base/commit/f527fb793476de865e0c7136ede2fbf87a63cad1)) - renovate[bot]
- (**deps**) update node.js to v24.20.0 - ([08e7bf0](https://github.com/aacebedo/devcontainer-base/commit/08e7bf0406e7f4268226698090537db144c002be)) - renovate[bot]
- (**deps**) update dependency sharkdp/fd to v10.5.0 - ([46753d9](https://github.com/aacebedo/devcontainer-base/commit/46753d91604d567e49829c3adf047cc3115b5bb4)) - renovate[bot]
- (**deps**) update dependency npm:renovate to v44.61.4 - ([09207f3](https://github.com/aacebedo/devcontainer-base/commit/09207f3ce55e06ada02b1c8b4ea258a797943382)) - renovate[bot]

- - -

## [v1.19.1](https://github.com/aacebedo/devcontainer-base/compare/acab6edd75cc0d0d4492663820abe45063e340c4..v1.19.1) - 2026-09-03
#### Bug Fixes
- (**deps**) update dependency gh to v2.100.0 - ([0ae8eaf](https://github.com/aacebedo/devcontainer-base/commit/0ae8eafbc0172e4aaaa569b9ae528e234ccc8c78)) - renovate[bot]
- (**deps**) update dependency atuinsh/atuin to v18.21.0 - ([c3f35c9](https://github.com/aacebedo/devcontainer-base/commit/c3f35c98c12772b2487412013c68d3be7ebba37c)) - renovate[bot]
- (**deps**) update dependency dprint to v0.57.1 - ([b4ded39](https://github.com/aacebedo/devcontainer-base/commit/b4ded39880a8da34651064925b53c221cbb73a96)) - renovate[bot]
- (**deps**) update dependency vale to v3.20.0 - ([58f01d7](https://github.com/aacebedo/devcontainer-base/commit/58f01d75451853bb3df65ed95e1577c0e8d8fb52)) - renovate[bot]
- (**deps**) update dependency prek to v0.5.2 - ([acab6ed](https://github.com/aacebedo/devcontainer-base/commit/acab6edd75cc0d0d4492663820abe45063e340c4)) - renovate[bot]

- - -

## [v1.19.0](https://github.com/aacebedo/devcontainer-base/compare/8987dca420184eff7064010870f9eb9a3ec59de8..v1.19.0) - 2026-09-03
#### Features
- split files in dockerfile - ([8987dca](https://github.com/aacebedo/devcontainer-base/commit/8987dca420184eff7064010870f9eb9a3ec59de8)) - Alexandre ACEBEDO

- - -

## [v1.18.12](https://github.com/aacebedo/devcontainer-base/compare/201d25d449b45e6bb089e31393f7ecc03486539b..v1.18.12) - 2026-08-22
#### Bug Fixes
- (**deps**) update dependency vale to v3.18.0 - ([8fb2279](https://github.com/aacebedo/devcontainer-base/commit/8fb227980c56dd94a73f5328ab9e4333793b9bf3)) - renovate[bot]
- (**deps**) update dependency npm:renovate to v44.39.2 - ([849920e](https://github.com/aacebedo/devcontainer-base/commit/849920e37ec3f1c946f36f6b20bf9740db28fb3f)) - renovate[bot]
- (**deps**) update dependency dprint to v0.56.1 - ([f3ec69f](https://github.com/aacebedo/devcontainer-base/commit/f3ec69f4999c1e090af4b0c98f33cdcb515afca0)) - renovate[bot]
- (**deps**) update dependency gh to v2.98.0 - ([9faa404](https://github.com/aacebedo/devcontainer-base/commit/9faa404fbe4aa70f548aa1bf288975162ada9bdb)) - renovate[bot]
- (**deps**) update dependency trivy to v0.74.0 - ([201d25d](https://github.com/aacebedo/devcontainer-base/commit/201d25d449b45e6bb089e31393f7ecc03486539b)) - renovate[bot]

- - -

## [v1.18.11](https://github.com/aacebedo/devcontainer-base/compare/e72b61d0a9a7c8889526e7eab81337ce4d4d37a3..v1.18.11) - 2026-08-10
#### Bug Fixes
- added run-container task and small fixes - ([c57097e](https://github.com/aacebedo/devcontainer-base/commit/c57097e3409e0744f6de267873f96bdd21cb72db)) - Alexandre ACEBEDO
- added cd script for mise - ([bf74c28](https://github.com/aacebedo/devcontainer-base/commit/bf74c28b0b96af43e8fe95dbf254d44d98080b38)) - Alexandre ACEBEDO
- format changes - ([14b50d6](https://github.com/aacebedo/devcontainer-base/commit/14b50d688b7408cffb6a2eea3e4b959ed9d4bc2a)) - Alexandre ACEBEDO
- clean format styles - ([e72b61d](https://github.com/aacebedo/devcontainer-base/commit/e72b61d0a9a7c8889526e7eab81337ce4d4d37a3)) - Alexandre ACEBEDO

- - -

## [v1.18.10](https://github.com/aacebedo/devcontainer-base/compare/5cadc4104e058251802b24bcebfa23c7dfb4dd33..v1.18.10) - 2026-08-09
#### Bug Fixes
- (**deps**) update dependency npm:renovate to v44.17.1 - ([280eb77](https://github.com/aacebedo/devcontainer-base/commit/280eb7768d5d9060d627fafbf251c0aedafc1a16)) - renovate[bot]
- (**deps**) update dependency editorconfig-checker to v3.11.1 - ([4fa0c82](https://github.com/aacebedo/devcontainer-base/commit/4fa0c82df9192b32ca8f3a26c4430fa31c4aa9a3)) - renovate[bot]
- (**deps**) update dependency jj-vcs/jj to v0.44.0 - ([5cadc41](https://github.com/aacebedo/devcontainer-base/commit/5cadc4104e058251802b24bcebfa23c7dfb4dd33)) - renovate[bot]

- - -

## [v1.18.9](https://github.com/aacebedo/devcontainer-base/compare/c95bcf203fc60976678cb0481324b6179784ed00..v1.18.9) - 2026-08-05
#### Bug Fixes
- (**deps**) update dependency npm:renovate to v44.13.2 - ([cc02314](https://github.com/aacebedo/devcontainer-base/commit/cc02314191305997215692cab4d8ae5e82b137f9)) - renovate[bot]
- (**deps**) update dependency atuinsh/atuin to v18.19.0 - ([0b2b290](https://github.com/aacebedo/devcontainer-base/commit/0b2b2900aabaecaf41b664c0319b2e439deb8777)) - renovate[bot]
- (**deps**) update node.js to v24.19.0 - ([3275b87](https://github.com/aacebedo/devcontainer-base/commit/3275b87ba1314f3962aa1ef13a7d30715b7c9a6b)) - renovate[bot]
- (**deps**) update dependency trivy to v0.73.0 - ([c95bcf2](https://github.com/aacebedo/devcontainer-base/commit/c95bcf203fc60976678cb0481324b6179784ed00)) - renovate[bot]

- - -

## [v1.18.8](https://github.com/aacebedo/devcontainer-base/compare/f286e5afd9554381b96a5afa58dc1c63e8621b32..v1.18.8) - 2026-08-02
#### Bug Fixes
- fix release creation - ([f286e5a](https://github.com/aacebedo/devcontainer-base/commit/f286e5afd9554381b96a5afa58dc1c63e8621b32)) - Alexandre ACEBEDO

- - -

## [v1.18.7](https://github.com/aacebedo/devcontainer-base/compare/2cd45fd7347eaa3f5876111375a1e124367ae241..v1.18.7) - 2026-08-02
#### Bug Fixes
- (**deps**) update dependency uv to v0.12.1 - ([2cd45fd](https://github.com/aacebedo/devcontainer-base/commit/2cd45fd7347eaa3f5876111375a1e124367ae241)) - renovate[bot]

- - -

## [v1.18.6](https://github.com/aacebedo/devcontainer-base/compare/f6525be43d649b41144e7581833b33c41e64788b..v1.18.6) - 2026-08-02
#### Bug Fixes
- switch back to the remote template for changelog - ([f6525be](https://github.com/aacebedo/devcontainer-base/commit/f6525be43d649b41144e7581833b33c41e64788b)) - Alexandre ACEBEDO

- - -

#### Bug Fixes
- 5d3519552edaadbdc716c085e789faf430b8bc05 - (**deps**) update dependency hadolint to v2.15.1 - renovate[bot]
- 225b44f83223fb131e55f32c3e710dff8768ab7e - fix missing token for setup action - Alexandre ACEBEDO

- 3fadd4a2a02790400076c598e5b64663800d3000 - remove hadolint warnings - Alexandre ACEBEDO


- - -

## v1.18.4 - 2026-08-02
#### Bug Fixes
- fixed CHANGELOG template - (7e14a2b) - Alexandre ACEBEDO

- - -

## [v1.18.3](https://github.com/${REPO_OWNER}/${REPO_NAME}/compare/2eb112b082019b44c19f1e2c36fec84849e609b1..v1.18.3) - 2026-08-02
#### Bug Fixes
- make cog ignore the merge commits - ([2eb112b](https://github.com/${REPO_OWNER}/${REPO_NAME}/commit/2eb112b082019b44c19f1e2c36fec84849e609b1)) - Alexandre ACEBEDO

- - -

## [v1.18.2](https://github.com/${REPO_OWNER}/${REPO_NAME}/compare/7091e29d8e3d6af0e719c563718a9aa921888837..v1.18.2) - 2026-08-02
#### Bug Fixes
- (**deps**) update dependency npm:renovate to v44 - ([ccffc39](https://github.com/${REPO_OWNER}/${REPO_NAME}/commit/ccffc39393b19bbf735b491f00b70af13676e377)) - renovate[bot]
- (**deps**) update dependency atuinsh/atuin to v18.18.1 - ([7091e29](https://github.com/${REPO_OWNER}/${REPO_NAME}/commit/7091e29d8e3d6af0e719c563718a9aa921888837)) - renovate[bot]

- - -

## [v1.18.1](https://github.com/${REPO_OWNER}/${REPO_NAME}/compare/18229d8f8f83fe1bdad562eaae8b8cb8f78f8179..v1.18.1) - 2026-08-02
#### Bug Fixes
- (**deps**) update dependency vale to v3.17.0 - ([fb10342](https://github.com/${REPO_OWNER}/${REPO_NAME}/commit/fb10342267f33de5c2d5022000b43c9e761db80b)) - renovate[bot]
- (**deps**) update dependency npm:renovate to v43.288.0 - ([8639c2e](https://github.com/${REPO_OWNER}/${REPO_NAME}/commit/8639c2e8ff18e0800704131c37e1d711b5b32812)) - renovate[bot]
- (**deps**) update dependency jdx/mise to v2026.8.0 - ([18229d8](https://github.com/${REPO_OWNER}/${REPO_NAME}/commit/18229d8f8f83fe1bdad562eaae8b8cb8f78f8179)) - renovate[bot]

- - -

## [v1.18.0](https://github.com/${REPO_OWNER}/${REPO_NAME}/compare/255fab5ee0ec4454e80d41c9dca6d68c702c0e4e..v1.18.0) - 2026-08-02
#### Features
- optimized CI and improved mise scripts - ([223a3c3](https://github.com/${REPO_OWNER}/${REPO_NAME}/commit/223a3c37a82c87ee922879ffdd262997c530fc21)) - Alexandre ACEBEDO
- add dprint - ([c717350](https://github.com/${REPO_OWNER}/${REPO_NAME}/commit/c71735079ad6774ca5e5fb39171e3bd43b8b774c)) - Alexandre ACEBEDO
- move to cog - ([255fab5](https://github.com/${REPO_OWNER}/${REPO_NAME}/commit/255fab5ee0ec4454e80d41c9dca6d68c702c0e4e)) - Alexandre ACEBEDO
#### Bug Fixes
- (**deps**) update dependency mise to 2026.7.18 - ([e9acde8](https://github.com/${REPO_OWNER}/${REPO_NAME}/commit/e9acde8d072993e9112924b6919c51845883f3e7)) - Alexandre ACEBEDO
- fix missing var for CI - ([c1fa1a3](https://github.com/${REPO_OWNER}/${REPO_NAME}/commit/c1fa1a3b25d7019dbf2ac59187daa7abad61195b)) - Alexandre ACEBEDO
- reset CHANGELOG.md - ([a44614a](https://github.com/${REPO_OWNER}/${REPO_NAME}/commit/a44614a51b6c486a499dec482e4e067e03e07406)) - Alexandre ACEBEDO

- - -

