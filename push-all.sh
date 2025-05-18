#!/bin/bash

# Mensagem de commit a ser usada em todos os repositórios
read -p "Digite a mensagem de commit: " commit_msg

echo ""
echo "=====> Atualizando e dando push nos submodules..."

# Para cada submodule registrado no .gitmodules
git submodule foreach '
  echo "Entrando em $name..."
  branch=$(git rev-parse --abbrev-ref HEAD)
  echo "Na branch: $branch"

  git add .
  git commit -m "'"$commit_msg"'"
  git push origin $branch

  echo ""
'

echo "=====> Voltando ao repositório pai e atualizando referência dos submodules..."

# Agora no projeto pai
git add .
git commit -m "Atualiza submodules: $commit_msg"
git push origin $(git rev-parse --abbrev-ref HEAD)

echo ""
echo "✅ Tudo pronto!"
