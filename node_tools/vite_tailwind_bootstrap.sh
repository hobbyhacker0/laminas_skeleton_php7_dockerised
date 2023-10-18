# Init vite project
# npm init @vitejs/app
# npm create vite@latest test-vite-fe -- --template react
npm init vite

cd vite-project
npm install
npm run dev

# Install tailwind
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p

# Configure paths
# cp ./tailwind.config.js /var/www