#!/bin/bash

# colores
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# contador
tests_passed=0

# funciones
test_output() {
  output=$($1)
  expected=$2
  if [[ "$output" == "$expected" ]]
  then
    echo -e "[  ${GREEN}OK${NC}  ]: $1 → $2 ${GREEN}✓${NC}"
    tests_passed=$((tests_passed + 1))
  else
    echo -e "[ ${RED}Fail${NC} ]: Esperaba '$expected' pero se obtuvo '$output' ${RED}✗${NC}"
  fi
}
test_output_spim() {
  output=$(echo $1 | $2)
  expected=$3
  if [[ "$output" == "$expected" ]]
  then
    echo -e "[  ${GREEN}OK${NC}  ]: echo $1 | $2 → $3 ${GREEN}✓${NC}"
    tests_passed=$((tests_passed + 1))
  else
    echo -e "[ ${RED}Fail${NC} ]: Esperaba '$expected' pero se obtuvo '$output' ${RED}✗${NC}"
  fi
}
test_output_redirect() {
  output=$($1 < $2)
  expected=$3
  if [[ "$output" == "$expected" ]]
  then
    echo -e "[  ${GREEN}OK${NC}  ]: $1 < $2 → $3 ${GREEN}✓${NC}"
    tests_passed=$((tests_passed + 1))
  else
    echo -e "[ ${RED}Fail${NC} ]: Esperaba '$expected' pero se obtuvo '$output' ${RED}✗${NC}"
  fi
}

# 1 saludo
test_output "spim -q -f saludo.s Milne" "Hola, Milne como andas?"
test_output "spim -q -f saludo.s Medina" "Hola, Medina como andas?"
test_output "spim -q -f saludo.s Juan" "Hola, Juan como andas?"
test_output "spim -q -f saludo.s Messi" "Hola, Messi como andas?"
test_output "spim -q -f saludo.s Scaloni" "Hola, Scaloni como andas?"
test_output "spim -q -f saludo.s Mirtha" "Hola, Mirtha como andas?"
test_output "spim -q -f saludo.s Alberto" "Hola, Alberto como andas?"
test_output "spim -q -f saludo.s Moiguer" "Hola, Moiguer como andas?"
test_output "spim -q -f saludo.s 1234" "Hola, 1234 como andas?"
test_output "spim -q -f saludo.s pibe" "Hola, pibe como andas?"
# 2 potencias
test_output_spim "2" "spim -q -f potencias.s" "4"
test_output_spim "3" "spim -q -f potencias.s" "8"
test_output_spim "4" "spim -q -f potencias.s" "16"
test_output_spim "0" "spim -q -f potencias.s" "1"
test_output_spim "1" "spim -q -f potencias.s" "2"
test_output_spim "-1" "spim -q -f potencias.s" "Error"
test_output_spim "-4" "spim -q -f potencias.s" "Error"
test_output_spim "7" "spim -q -f potencias.s" "128"
test_output_spim "10" "spim -q -f potencias.s" "1024"
test_output_spim "8" "spim -q -f potencias.s" "256"

# resultado final
echo "--------------  Resultado  --------------"
if [[ $tests_passed -eq 20 ]]
then
  echo -e "Todos los tests pasaron ${GREEN}✓${NC}"
else
  echo "Resultado: $tests_passed/20 tests OK."
fi

exit 0
