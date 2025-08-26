# PPT Copilot 项目GitHub上传指南

## 📋 目录
1. [上传前准备](#上传前准备)
2. [文件整理](#文件整理)
3. [敏感信息处理](#敏感信息处理)
4. [Git仓库配置](#git仓库配置)
5. [GitHub仓库创建](#github仓库创建)
6. [推送到GitHub](#推送到github)
7. [注意事项](#注意事项)
8. [最佳实践](#最佳实践)

## 🔧 上传前准备

### 1. 检查项目完整性
```bash
# 确认所有子模块都已克隆
git submodule status

# 检查项目结构
tree -L 3 PPTCopilot/
```

### 2. 系统测试
- ✅ 确保Docker Compose能正常启动
- ✅ 验证前端页面可访问
- ✅ 测试AI功能正常工作
- ✅ 数据库连接正常

## 📁 文件整理

### 需要上传的文件
```
PPTCopilot/
├── docker-compose.yaml          # ✅ 核心配置
├── README.md                    # ✅ 项目说明
├── 使用手册.md                   # ✅ 使用文档
├── LICENSE                      # ✅ 开源许可
├── .gitignore                   # ✅ Git忽略规则
├── .gitmodules                  # ✅ 子模块配置
├── PPTCopilot-backend/         # ✅ 后端子模块
├── PPTCopilot-editor/          # ✅ 编辑器子模块
├── PPTCopilot-project/         # ✅ 项目管理子模块
└── screenshots/                # ✅ 项目截图（可选）
```

### 需要排除的文件
```bash
# 临时文件
.DS_Store
*.log
tmp/
temp/

# Docker数据
.docker/
volumes/

# 本地配置
.env
.env.local

# 用户上传的文件
static/user/*/
static/project/*/
```

## 🔐 敏感信息处理

### 1. 创建配置模板文件

```bash
# 创建配置模板（移除敏感信息）
cp PPTCopilot-backend/conf/gpt.conf PPTCopilot-backend/conf/gpt.conf.template
cp PPTCopilot-backend/conf/emailverify.conf PPTCopilot-backend/conf/emailverify.conf.template
```

### 2. 编辑模板文件
```bash
# gpt.conf.template 示例
gpt_api_url = `https://api.openai.com/v1/chat/completions`
gpt_model = `gpt-3.5-turbo`
gpt_proxy = `http://localhost:7890`
gpt_api_key = `your-openai-api-key-here`

# 或者ollama配置
gpt_api_url = `http://host.docker.internal:11434/v1/chat/completions`
gpt_model = `qwen3:4b-instruct`
gpt_proxy = ``
gpt_api_key = `ollama-local-key`
```

### 3. 更新Docker配置
```yaml
# docker-compose.yaml中移除敏感的环境变量
version: '3'
services:
  pptcopilot-backend:
    build:
      context: ./PPTCopilot-backend
      dockerfile: Dockerfile
      args:
        MYSQL_HOST: mysqldb
        MYSQL_PORT: 3306
        SERVER_IP: "localhost"
    # 移除实际的API密钥
```

## 🔧 Git仓库配置

### 1. 创建.gitignore文件
```bash
# 编辑.gitignore
vim .gitignore
```

### 2. .gitignore内容
```gitignore
# 编译产物
dist/
build/
*.o
*.a
*.so
*.exe

# 依赖包
node_modules/
vendor/
__pycache__/
*.pyc

# 日志文件
*.log
logs/

# 环境配置
.env
.env.local
.env.production

# 敏感配置文件（保留模板）
**/conf/gpt.conf
**/conf/emailverify.conf
!**/conf/*.conf.template

# IDE文件
.vscode/
.idea/
*.swp
*.swo
*~

# 系统文件
.DS_Store
Thumbs.db

# Docker数据
docker-compose.override.yml
volumes/

# 临时文件
tmp/
temp/
.cache/

# 数据库文件
*.db
*.sqlite

# 用户上传的文件
static/user/*/
static/project/*/
scripts/connect.sh

# 测试文件
coverage/
*.cover
```

### 3. 初始化Git仓库
```bash
cd PPTCopilot

# 如果还没有Git仓库
git init

# 检查当前状态
git status
```

### 4. 处理子模块
```bash
# 检查子模块配置
cat .gitmodules

# 添加子模块（如果需要）
git submodule add git@github.com:hughdazz/PPTCopilotBackend.git PPTCopilot-backend
git submodule add git@github.com:hughdazz/PPTCopilotEditor.git PPTCopilot-editor
git submodule add git@github.com:hughdazz/PPTCopilotProject.git PPTCopilot-project
```

## 🚀 GitHub仓库创建

### 1. 在GitHub创建仓库
1. 访问 https://github.com
2. 点击"New repository"
3. 填写仓库信息：
   - **Repository name**: `PPTCopilot`
   - **Description**: `🤖 AI-Powered PPT Generation and Editing Platform`
   - **Visibility**: Public/Private
   - **Initialize**: 不要勾选README、.gitignore、license

### 2. 仓库设置建议
```
Repository name: PPTCopilot
Description: 🤖 AI-Powered PPT Generation and Editing Platform | 基于AI的智能PPT生成与编辑平台
Topics: ai, ppt, powerpoint, vue, golang, docker, ollama, chatgpt
License: MIT
```

## 📤 推送到GitHub

### 1. 添加远程仓库
```bash
# 添加GitHub远程仓库
git remote add origin git@github.com:yourusername/PPTCopilot.git

# 或使用HTTPS
git remote add origin https://github.com/yourusername/PPTCopilot.git
```

### 2. 提交文件
```bash
# 添加所有文件
git add .

# 检查要提交的文件
git status

# 提交
git commit -m "🎉 Initial commit: PPT Copilot - AI-powered PPT generation platform

✨ Features:
- 🤖 AI-powered PPT outline generation
- 📝 Intelligent content filling
- 🎨 Online PPT editor
- 👥 User and project management
- 🏠 Local Ollama model support
- 🐳 Docker containerization

🔧 Tech Stack:
- Backend: Go + Beego
- Frontend: Vue.js + Element UI
- Editor: Vue.js + Canvas
- Database: MySQL
- AI: OpenAI GPT / Local Ollama
- Deploy: Docker + Docker Compose"
```

### 3. 推送到GitHub
```bash
# 推送主分支
git branch -M main
git push -u origin main

# 推送子模块
git submodule foreach git push origin main
```

## ⚠️ 注意事项

### 1. 安全考虑
- **绝不上传**：API密钥、数据库密码、私人邮箱配置
- **使用模板文件**：提供配置示例而非实际配置
- **环境变量**：敏感信息通过环境变量传入
- **权限设置**：考虑是否设为私有仓库

### 2. 子模块处理
- 确保子模块仓库都已公开（如果主仓库是公开的）
- 子模块的提交历史会被保留
- 更新子模块需要单独推送

### 3. 文件大小
- GitHub单文件限制100MB
- 检查是否有大文件需要使用Git LFS
- 考虑压缩图片和静态资源

### 4. 许可证选择
```bash
# 建议使用MIT许可证
# 创建LICENSE文件
```

## 🎯 最佳实践

### 1. 创建完整的README.md
```markdown
# PPT Copilot

🤖 AI-Powered PPT Generation and Editing Platform

## Features
- AI-powered PPT generation
- Online editing
- Local Ollama support
- Docker deployment

## Quick Start
\`\`\`bash
git clone --recursive https://github.com/yourusername/PPTCopilot.git
cd PPTCopilot
docker-compose up -d
\`\`\`

## Documentation
- [使用手册](使用手册.md)
- [API文档](docs/api.md)

## License
MIT
```

### 2. 标签和发布
```bash
# 创建版本标签
git tag -a v1.0.0 -m "Release v1.0.0: Initial stable release"
git push origin v1.0.0
```

### 3. 分支策略
```bash
# 创建开发分支
git checkout -b develop
git push -u origin develop

# 功能分支
git checkout -b feature/ollama-integration
```

### 4. GitHub Actions（可选）
```yaml
# .github/workflows/ci.yml
name: CI
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Test Docker Build
        run: docker-compose build
```

## 📝 提交信息规范

```bash
# 使用约定式提交
git commit -m "feat: add Ollama local model support"
git commit -m "fix: resolve proxy connection issue"
git commit -m "docs: update README with installation guide"
git commit -m "style: improve UI components"
git commit -m "refactor: optimize API request handling"
```

## 🔄 维护和更新

### 定期维护任务
1. **依赖更新**：定期更新Docker镜像和npm包
2. **安全扫描**：检查已知漏洞
3. **文档更新**：保持文档与代码同步
4. **Issue管理**：及时响应用户反馈

### 版本发布流程
1. 功能开发完成
2. 测试通过
3. 更新版本号
4. 创建Release Notes
5. 发布到GitHub

---

**准备好后，就可以将您的PPT Copilot项目分享给全世界了！** 🌟
