$departamentos = Get-ADUser -Filter * -Properties department -SearchBase "OU=UsersID,DC=dominio,DC=local" | Select-Object department -Unique
$departamentos.department | ForEach-Object {
    if ($_) {
        $titulo = "`nUsuarios del departamento " + $_
        Write-Host $titulo
        "=" * $titulo.Length
        Get-ADUser -Properties department -Filter {department -Like $_} | Select-Object -Property name
    }
    else {
        $titulo = "`nUsuarios sin departamento "
        Write-Host $titulo
        "=" * $titulo.Length
        Get-ADUser -Properties department -Filter {-not (department -Like "*")} | Select-Object -Property name    
    }
}
