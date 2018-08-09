# WTF IS THIS?
It's an experiment of monorepo using [lerna](https://github.com/lerna/lerna) for **private packages** when your organization can't afford $7/user/month with [npm Private Packages](https://www.npmjs.com/pricing)

### Q: Monorepo? Lerna?
A: See [this](https://github.com/lerna/lerna#about)

### Q: So what are you trying to do?
A: Well, I find lerna useful but I can't afford to be a paid npm user for private packages so I'm trying to use [git-hosted dependencies](https://github.com/lerna/lerna#git-hosted-dependencies)

### Q: But you need to be a paid GitHub user to host these packages privately?
A: Yep, I'm in GitHub Student Developer Pack. But Bitbucket & Gitlab work just fine

### Q: Any problems?
A: Yeah, kinda, self-hosted git instances. Because lerna depends on [hosted-git-info](https://www.npmjs.com/package/hosted-git-info), you won't be able to publish packages to your own self-hosted instance. See [this comment](https://github.com/npm/hosted-git-info/issues/27#issuecomment-400072894). So, meh :confused:

### Q: So what should I do in that case?
A: Deploy your own registry

### Q: Alright, how to use this thing?
A: I wrote a script [mirror.sh](mirror.sh) to automate the process of splitting packages to their own repository using [splitsh/lite](https://github.com/splitsh/lite). So processes should be like this:

#### Setup
1. Split current packages
```bash
./mirror.sh
```

2. Update dependencies
```json
 "dependencies": {
-  "@hiendv/lerna-git-hosted-foo": "^2.0.0",
+  "@hiendv/lerna-git-hosted-foo": "git+ssh://git@github.com/hiendv/lerna-git-hosted-foo.git#semver:^2.0.0"
 }
```

3. Update `lerna.json`
```json
+  "useGitVersion": true,
+  "gitVersionPrefix": "v"
```

4. Bootstrap lerna
```bash
lerna clean --yes && lerna bootstrap --hoist
```
These steps should be done successfully.

#### Workflow
```bash
# Make some changes to the codebase
git add changed/files
git commit

# Bump the versions & publish
lerna publish

# Split
./mirror.sh
```
Versions should be updated correctly and mirrored repositories should contains new versions.

[This repository](https://github.com/hiendv/lerna-git-hosted) is a monorepo with packages mirrored to [hiendv/lerna-git-hosted-foo](https://github.com/hiendv/lerna-git-hosted-foo) and [hiendv/lerna-git-hosted-bar](https://github.com/hiendv/lerna-git-hosted-bar). If I make them private, you will never know them but it still works for me, that's the point of this. So, see for yourself, good luck!