# 🤖 PPT Copilot

> AI-Powered PPT Generation and Editing Platform | 基于AI的智能PPT生成与编辑平台

<div align="center">

![PPT Copilot Logo](screenshots/logo.png)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Docker](https://img.shields.io/badge/Docker-Ready-blue)](https://www.docker.com/)
[![Ollama](https://img.shields.io/badge/Ollama-Supported-green)](https://ollama.ai/)
[![Vue.js](https://img.shields.io/badge/Vue.js-3.x-4FC08D)](https://vuejs.org/)
[![Go](https://img.shields.io/badge/Go-1.20-00ADD8)](https://golang.org/)

[English](#english) | [中文](#中文)

</div>

## 中文

### ✨ 特性

- 🤖 **AI智能生成**：基于主题自动生成PPT大纲和内容
- 📝 **内容填充**：AI智能填充每页PPT的详细内容  
- 🎨 **在线编辑**：功能强大的在线PPT编辑器
- 👥 **用户管理**：完整的用户注册、登录、项目管理系统
- 🏠 **本地模型**：支持Ollama本地AI模型，无需API费用
- 🐳 **容器化部署**：Docker一键部署，环境一致
- 🔒 **数据安全**：支持本地部署，数据完全可控

### 🛠️ 技术栈

- **前端**: Vue.js 3 + Element UI + TDesign
- **后端**: Go + Beego Framework
- **数据库**: MySQL 8.0
- **编辑器**: Canvas + ProseMirror
- **AI模型**: OpenAI GPT / Local Ollama
- **部署**: Docker + Docker Compose

### 🚀 快速开始

#### 环境要求
- Docker & Docker Compose
- Git
- 8GB+ 内存（推荐）

#### 1. 克隆项目
```bash
git clone --recursive https://github.com/yourusername/PPTCopilot.git
cd PPTCopilot
```

#### 2. 启动系统
```bash
# 启动所有服务
docker-compose up -d

# 查看服务状态
docker-compose ps
```

#### 3. 访问系统
- **项目管理**: http://localhost:9529
- **PPT编辑器**: http://localhost:7777  
- **后端API**: http://localhost:8080

#### 4. 默认账号
- 用户名: `hughdazz`
- 密码: `123456`

### 🤖 AI配置

#### 选项1：使用Ollama（推荐）
```bash
# 安装Ollama
curl -fsSL https://ollama.ai/install.sh | sh

# 下载模型
ollama pull qwen3:4b-instruct

# 启动服务  
ollama serve
```

#### 选项2：使用OpenAI
```bash
# 复制配置模板
cp PPTCopilot-backend/conf/gpt.conf.template PPTCopilot-backend/conf/gpt.conf

# 编辑配置文件，添加您的API密钥
vim PPTCopilot-backend/conf/gpt.conf
```

### 📖 使用指南

1. **访问系统**：打开 http://localhost:9529
2. **登录/注册**：使用默认账号或注册新账号
3. **创建项目**：点击"新建项目"
4. **生成PPT**：
   - 点击"新建PPT"
   - 输入主题（如"人工智能发展趋势"）
   - 选择模板
   - 等待AI生成大纲
   - 确认后生成详细内容
5. **在线编辑**：使用编辑器调整样式和内容

### 📁 项目结构

```
PPTCopilot/
├── docker-compose.yaml          # Docker编排配置
├── PPTCopilot-backend/          # Go后端服务
├── PPTCopilot-editor/           # Vue.js编辑器
├── PPTCopilot-project/          # Vue.js项目管理
├── 使用手册.md                   # 详细使用说明
└── GitHub上传指南.md             # GitHub部署指南
```

### 🤝 贡献

欢迎提交Issue和Pull Request！

### 📄 许可证

MIT License - 详见 [LICENSE](LICENSE) 文件

---

## English

### ✨ Features

- 🤖 **AI-Powered Generation**: Automatically generate PPT outlines and content based on topics
- 📝 **Content Filling**: Intelligently fill detailed content for each PPT slide
- 🎨 **Online Editor**: Powerful online PPT editor with rich features
- 👥 **User Management**: Complete user registration, login, and project management system
- 🏠 **Local Models**: Support for Ollama local AI models, no API fees required
- 🐳 **Containerized**: One-click Docker deployment with consistent environments
- 🔒 **Data Security**: Support for local deployment with full data control

### 🛠️ Tech Stack

- **Frontend**: Vue.js 3 + Element UI + TDesign
- **Backend**: Go + Beego Framework
- **Database**: MySQL 8.0
- **Editor**: Canvas + ProseMirror
- **AI Models**: OpenAI GPT / Local Ollama
- **Deployment**: Docker + Docker Compose

### 🚀 Quick Start

#### Requirements
- Docker & Docker Compose
- Git
- 8GB+ Memory (Recommended)

#### 1. Clone Repository
```bash
git clone --recursive https://github.com/yourusername/PPTCopilot.git
cd PPTCopilot
```

#### 2. Start System
```bash
# Start all services
docker-compose up -d

# Check service status
docker-compose ps
```

#### 3. Access System
- **Project Management**: http://localhost:9529
- **PPT Editor**: http://localhost:7777
- **Backend API**: http://localhost:8080

#### 4. Default Account
- Username: `hughdazz`
- Password: `123456`

### 🤖 AI Configuration

#### Option 1: Use Ollama (Recommended)
```bash
# Install Ollama
curl -fsSL https://ollama.ai/install.sh | sh

# Download model
ollama pull qwen3:4b-instruct

# Start service
ollama serve
```

#### Option 2: Use OpenAI
```bash
# Copy configuration template
cp PPTCopilot-backend/conf/gpt.conf.template PPTCopilot-backend/conf/gpt.conf

# Edit configuration file, add your API key
vim PPTCopilot-backend/conf/gpt.conf
```

### 📖 Usage Guide

1. **Access System**: Open http://localhost:9529
2. **Login/Register**: Use default account or register new account
3. **Create Project**: Click "New Project"
4. **Generate PPT**:
   - Click "New PPT"
   - Enter topic (e.g., "AI Development Trends")
   - Select template
   - Wait for AI to generate outline
   - Confirm and generate detailed content
5. **Online Edit**: Use editor to adjust styles and content

### 🤝 Contributing

Issues and Pull Requests are welcome!

### 📄 License

MIT License - see [LICENSE](LICENSE) file for details

---

<div align="center">

**Made with ❤️ by PPT Copilot Team**

[Documentation](使用手册.md) • [GitHub Guide](GitHub上传指南.md) • [Issues](https://github.com/yourusername/PPTCopilot/issues)

</div>