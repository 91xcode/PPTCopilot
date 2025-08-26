#!/usr/bin/env bash
# PPTCopilot Fork项目上传脚本
# 使用前请确保：
# 1. 已在GitHub上Fork所有子仓库
# 2. 配置了SSH密钥
# 3. 替换GITHUB_USERNAME为你的用户名

set -e  # 遇到错误立即退出

# 配置区域 - 请修改为你的GitHub用户名
GITHUB_USERNAME="91xcode"  # ⚠️ 请替换为你的GitHub用户名

# 颜色输出函数
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 检查用户名是否已修改
if [[ "$GITHUB_USERNAME" == "yourusername" ]]; then
    log_error "请先修改脚本中的GITHUB_USERNAME变量为你的GitHub用户名！"
    exit 1
fi

log_info "🚀 开始处理PPTCopilot项目Fork上传..."
log_warning "请确保你已经在GitHub上Fork了以下仓库:"
echo "   - hughdazz/PPTCopilotBackend"
echo "   - hughdazz/PPTCopilotEditor" 
echo "   - hughdazz/PPTCopilotProject"
echo ""
read -p "是否已完成Fork操作？(y/n): " fork_confirm
if [[ $fork_confirm != [yY] ]]; then
    log_error "请先完成Fork操作后再运行此脚本"
    exit 1
fi

# 检查当前目录
if [[ ! -f "docker-compose.yaml" ]] || [[ ! -d "PPTCopilot-backend" ]]; then
    log_error "请在PPTCopilot项目根目录下运行此脚本"
    exit 1
fi

log_info "📦 开始处理子模块..."

# 获取子模块对应的GitHub仓库名
get_repo_name() {
    case "$1" in
        "PPTCopilot-backend")
            echo "PPTCopilotBackend"
            ;;
        "PPTCopilot-editor") 
            echo "PPTCopilotEditor"
            ;;
        "PPTCopilot-project")
            echo "PPTCopilotProject"
            ;;
        *)
            echo "$1"
            ;;
    esac
}

# 处理每个子模块
for submodule in PPTCopilot-backend PPTCopilot-editor PPTCopilot-project; do
    if [[ ! -d "$submodule" ]]; then
        log_warning "子模块 $submodule 不存在，跳过"
        continue
    fi
    
    log_info "🔧 处理子模块: $submodule"
    cd "$submodule"
    
    # 检查是否有修改
    if git diff --quiet && git diff --cached --quiet; then
        log_warning "$submodule 没有修改，跳过提交"
    else
        log_info "发现 $submodule 有修改，准备提交..."
        git status
        echo ""
        read -p "是否提交 $submodule 的修改？(y/n): " commit_confirm
        if [[ $commit_confirm == [yY] ]]; then
            git add .
            git commit -m "feat: 更新配置，支持本地Ollama模型和Docker优化

- 🤖 添加本地Ollama模型支持
- 🔧 修复Docker构建问题  
- 📝 改进配置文件
- 🚀 优化构建流程"
            log_success "✅ $submodule 提交完成"
        else
            log_warning "⏭️  跳过 $submodule 的提交"
        fi
    fi
    
    # 更新远程URL
    repo_name=$(get_repo_name "$submodule")
    new_url="git@github.com:${GITHUB_USERNAME}/${repo_name}.git"
    
    log_info "🔗 更新 $submodule 的远程URL为: $new_url"
    git remote set-url origin "$new_url"
    
    # 推送到新的远程仓库
    log_info "📤 推送 $submodule 到你的仓库..."
    if git push origin master; then
        log_success "✅ $submodule 推送成功"
    else
        log_error "❌ $submodule 推送失败，请检查："
        echo "   1. 是否已Fork对应仓库？"
        echo "   2. SSH密钥是否配置正确？"
        echo "   3. 网络连接是否正常？"
        read -p "是否继续处理其他子模块？(y/n): " continue_confirm
        if [[ $continue_confirm != [yY] ]]; then
            exit 1
        fi
    fi
    
    cd ..
    echo ""
done

log_info "🔧 更新主仓库的.gitmodules文件..."

# 备份原.gitmodules
if [[ -f ".gitmodules" ]]; then
    cp .gitmodules .gitmodules.backup
    log_info "📋 已备份原.gitmodules为.gitmodules.backup"
fi

# 更新.gitmodules文件
cat > .gitmodules << EOF
[submodule "PPTCopilot-backend"]
	path = PPTCopilot-backend
	url = git@github.com:${GITHUB_USERNAME}/PPTCopilotBackend.git
[submodule "PPTCopilot-project"]
	path = PPTCopilot-project
	url = git@github.com:${GITHUB_USERNAME}/PPTCopilotProject.git
[submodule "PPTCopilot-editor"]
	path = PPTCopilot-editor
	url = git@github.com:${GITHUB_USERNAME}/PPTCopilotEditor.git
EOF

log_success "✅ .gitmodules文件更新完成"

# 同步子模块配置
log_info "🔄 同步子模块配置..."
git submodule sync

# 验证子模块远程URL
log_info "🔍 验证子模块远程URL..."
git submodule foreach 'echo "模块: $(basename $PWD)" && git remote -v && echo ""'

# 处理主仓库
log_info "🏠 准备推送主仓库..."

# 检查是否已有远程仓库
if git remote get-url origin >/dev/null 2>&1; then
    current_origin=$(git remote get-url origin)
    log_warning "当前主仓库remote origin: $current_origin"
    read -p "是否更新为你的仓库？(y/n): " update_origin
    if [[ $update_origin == [yY] ]]; then
        git remote set-url origin "git@github.com:${GITHUB_USERNAME}/PPTCopilot.git"
    fi
else
    git remote add origin "git@github.com:${GITHUB_USERNAME}/PPTCopilot.git"
fi

# 添加并提交主仓库的修改
git add .

# 检查是否有修改需要提交
if git diff --cached --quiet; then
    log_warning "主仓库没有新的修改需要提交"
else
    log_info "📝 提交主仓库修改..."
    git commit -m "🎉 Fork PPTCopilot项目并添加个人定制

✨ 主要特性:
- 🤖 本地Ollama模型支持 (qwen3:4b-instruct)  
- 🔧 Docker构建优化和错误修复
- 📝 完整的中文使用文档
- 🚀 前端构建流程改进
- 🔒 数据库连接配置优化
- 📋 详细的GitHub上传指南

🛠️ 技术栈:
- Backend: Go + Beego + MySQL
- Frontend: Vue.js + Element UI  
- Editor: Vue.js + Canvas
- AI: Local Ollama / OpenAI
- Deploy: Docker + Docker Compose

Based on hughdazz/PPTCopilot with significant improvements"
    log_success "✅ 主仓库修改提交完成"
fi

# 推送主仓库
log_info "📤 推送主仓库到GitHub..."
read -p "⚠️  即将推送到 git@github.com:${GITHUB_USERNAME}/PPTCopilot.git，确认继续？(y/n): " final_confirm
if [[ $final_confirm == [yY] ]]; then
    if git push -u origin master; then
        log_success "🎉 主仓库推送成功！"
    else
        log_error "❌ 主仓库推送失败，请检查是否已在GitHub创建PPTCopilot仓库"
        exit 1
    fi
else
    log_warning "⏭️  取消推送操作"
    exit 0
fi

# 显示成功信息
echo ""
log_success "🎉 恭喜！PPTCopilot项目已成功上传到你的GitHub账户"
echo ""
echo "📋 项目信息:"
echo "   主仓库: https://github.com/${GITHUB_USERNAME}/PPTCopilot"
echo "   后端:   https://github.com/${GITHUB_USERNAME}/PPTCopilotBackend"  
echo "   编辑器: https://github.com/${GITHUB_USERNAME}/PPTCopilotEditor"
echo "   项目管理: https://github.com/${GITHUB_USERNAME}/PPTCopilotProject"
echo ""
echo "🧪 测试克隆:"
echo "   git clone --recursive git@github.com:${GITHUB_USERNAME}/PPTCopilot.git"
echo ""
echo "🚀 启动项目:"
echo "   cd PPTCopilot && docker-compose up -d"
echo ""
log_info "💡 建议接下来："
echo "   1. 更新GitHub仓库描述和README"
echo "   2. 设置合适的topics标签"  
echo "   3. 考虑创建Release版本"
echo "   4. 在新环境测试完整克隆流程"
