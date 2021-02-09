;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\s*(([/-9!#-'*+=?A-~-]+(?:\.[/-9!#-'*+=?A-~-]+)*|"(?:[^"\r\n\\]|\\.)*")@([A-Za-z][0-9A-Za-z-]*[0-9A-Za-z]?(?:\.[A-Za-z][0-9A-Za-z-]*[0-9A-Za-z]?)*|\[(?:[^\[\]\r\n\\]|\\.)*\]))\s*$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u0085\"\"@m-"
(define-fun Witness1 () String (seq.++ "\x85" (seq.++ "\x22" (seq.++ "\x22" (seq.++ "@" (seq.++ "m" (seq.++ "-" "")))))))
;witness2: "`@[] \xA"
(define-fun Witness2 () String (seq.++ "`" (seq.++ "@" (seq.++ "[" (seq.++ "]" (seq.++ " " (seq.++ "\x0a" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.++ (re.union (re.++ (re.+ (re.union (re.range "!" "!")(re.union (re.range "#" "'")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "/" "9")(re.union (re.range "=" "=")(re.union (re.range "?" "?") (re.range "A" "~"))))))))) (re.* (re.++ (re.range "." ".") (re.+ (re.union (re.range "!" "!")(re.union (re.range "#" "'")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "/" "9")(re.union (re.range "=" "=")(re.union (re.range "?" "?") (re.range "A" "~")))))))))))) (re.++ (re.range "\x22" "\x22")(re.++ (re.* (re.union (re.union (re.range "\x00" "\x09")(re.union (re.range "\x0b" "\x0c")(re.union (re.range "\x0e" "!")(re.union (re.range "#" "[") (re.range "]" "\xff"))))) (re.++ (re.range "\x5c" "\x5c") (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))) (re.range "\x22" "\x22"))))(re.++ (re.range "@" "@") (re.union (re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.opt (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (re.* (re.++ (re.range "." ".")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.opt (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))))))) (re.++ (re.range "[" "[")(re.++ (re.* (re.union (re.union (re.range "\x00" "\x09")(re.union (re.range "\x0b" "\x0c")(re.union (re.range "\x0e" "Z") (re.range "^" "\xff")))) (re.++ (re.range "\x5c" "\x5c") (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))) (re.range "]" "]"))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
