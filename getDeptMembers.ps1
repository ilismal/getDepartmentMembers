$departamentos = Get-ADUser -Filter * -Properties department | Select-Object department -Unique
$departamentos.department | ForEach-Object {
    $departamento = $_
    if ($departamento) {
        $titulo = "`nUsuarios del departamento " + $departamento
        Write-Host $titulo
        "=" * $titulo.Length
        Get-ADUser -Properties department -Filter {department -Like $departamento} | Select-Object -Property name
    }
    else {
        $titulo = "`nUsuarios sin departamento "
        Write-Host $titulo
        "=" * $titulo.Length
        Get-ADUser -Properties department -Filter {-not (department -Like "*")} | Select-Object -Property name    
    }
}
