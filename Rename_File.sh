Get-ChildItem *.xml | Rename-Item -NewName { $_.Name -replace "kHC_AG\.", "kHC_AG.C." }

Get-ChildItem -Filter "kHC_AG.*.xml" | ForEach-Object {
    # Substituir o padrão do nome antigo para o novo
    $newName = $_.Name -replace "kHC_AG\.", "kHC_AG.C."
    # Renomear o arquivo
    Rename-Item -Path $_.FullName -NewName $newName
}