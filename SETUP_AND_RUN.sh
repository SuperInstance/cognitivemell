#!/bin/bash

# COMPLETE AUTOMATED DEPLOYMENT - Setup and Run Script
# This script handles the entire setup and deployment process

echo "🚀 COMPLETE AUTOMATED DEPLOYMENT SYSTEM"
echo "======================================"
echo ""

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed!"
    echo "Please install Node.js 18+ from https://nodejs.org/"
    exit 1
fi

NODE_VERSION=$(node --version | cut -d'v' -f2)
MAJOR_VERSION=$(echo $NODE_VERSION | cut -d'.' -f1)

if [ "$MAJOR_VERSION" -lt 18 ]; then
    echo "❌ Node.js version 18+ required! Current: $NODE_VERSION"
    exit 1
fi

echo "✅ Node.js version: $NODE_VERSION"
echo ""

# Check if Cloudflare API token is set
if [ -z "$CLOUDFLARE_API_TOKEN" ]; then
    echo "🔑 CLOUDFLARE_API_TOKEN not found!"
    echo ""
    echo "📝 To get your API token:"
    echo "1. Go to: https://dash.cloudflare.com/"
    echo "2. Click your profile → Edit Profile → API Tokens"
    echo "3. Click 'Create Token' → 'Edit zone DNS'"
    echo "4. Zone Resources: superinstance.ai"
    echo "5. Permissions: Zone:DNS:Edit"
    echo "6. Click 'Create token'"
    echo ""
    echo "🔧 Then run this command:"
    echo "export CLOUDFLARE_API_TOKEN=your_token_here"
    echo ""
    echo "🚀 Or run with the token directly:"
    echo "CLOUDFLARE_API_TOKEN=your_token_here ./SETUP_AND_RUN.sh"
    echo ""
    exit 1
fi

echo "✅ Cloudflare API token found"
echo ""

# Check internet connection
echo "🌐 Testing internet connection..."
if curl -s --head https://api.cloudflare.com/client/v4 > /dev/null; then
    echo "✅ Internet connection verified"
else
    echo "❌ Internet connection failed!"
    echo "Please check your internet connection and try again."
    exit 1
fi
echo ""

# Start the automated deployment
echo "🚀 Starting COMPLETE AUTOMATED DEPLOYMENT..."
echo "==========================================="
echo ""

# Run the deployment system
node COMPLETE_AUTOMATED_DEPLOYMENT_SYSTEM.js

DEPLOYMENT_RESULT=$?

if [ $DEPLOYMENT_RESULT -eq 0 ]; then
    echo ""
    echo "🎉 DEPLOYMENT COMPLETED SUCCESSFULLY!"
    echo "====================================="
    echo ""
    echo "📋 Next Steps:"
    echo "1. 🌐 Access your AI platform:"
    echo "   Primary: https://app.superinstance.ai/test/web-interface.html"
    echo "   Backup:  https://ai.superinstance.ai/test/web-interface.html"
    echo ""
    echo "2. 📊 Monitor your platform:"
    echo "   ./health-check.sh"
    echo ""
    echo "3. 🧹 Cleanup if needed:"
    echo "   ./cleanup-deployment.sh"
    echo ""
    echo "4. 📄 View deployment details:"
    echo "   cat DEPLOYMENT_REPORT.json"
    echo ""
    echo "🚀 You can now close the Cloudflare dashboard!"
    echo "   Your AI platform is ready to use!"
else
    echo ""
    echo "❌ DEPLOYMENT FAILED!"
    echo "===================="
    echo ""
    echo "📋 Check the error above and try again."
    echo "If you continue to have issues, check:"
    echo "• CLOUDFLARE_API_TOKEN is correct"
    echo "• Internet connection is stable"
    echo "• Cloudflare account has proper permissions"
    echo ""
    echo "📄 View detailed log:"
    echo "cat DEPLOYMENT_LOG.json"
    exit 1
fi