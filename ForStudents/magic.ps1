$variables = '(','(',' surprise.txt)){ ', ' ', ' surprise.txt}'
$answer = ''
$counter = 0

Foreach ($i in $variables){
    $answer += Get-Content answer.txt | Select -Index ($counter)
    $answer += $i
    $counter++
}

$answer




