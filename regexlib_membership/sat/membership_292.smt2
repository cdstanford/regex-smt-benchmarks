;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\s*(([/-9!#-'*+=?A-~-]+(?:\.[/-9!#-'*+=?A-~-]+)*|"(?:[^"\r\n\\]|\\.)*")@([A-Za-z][0-9A-Za-z-]*[0-9A-Za-z]?(?:\.[A-Za-z][0-9A-Za-z-]*[0-9A-Za-z]?)*|\[(?:[^\[\]\r\n\\]|\\.)*\]))\s*$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u0085\"\"@m-"
(define-fun Witness1 () String (str.++ "\u{85}" (str.++ "\u{22}" (str.++ "\u{22}" (str.++ "@" (str.++ "m" (str.++ "-" "")))))))
;witness2: "`@[] \xA"
(define-fun Witness2 () String (str.++ "`" (str.++ "@" (str.++ "[" (str.++ "]" (str.++ " " (str.++ "\u{0a}" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.++ (re.union (re.++ (re.+ (re.union (re.range "!" "!")(re.union (re.range "#" "'")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "/" "9")(re.union (re.range "=" "=")(re.union (re.range "?" "?") (re.range "A" "~"))))))))) (re.* (re.++ (re.range "." ".") (re.+ (re.union (re.range "!" "!")(re.union (re.range "#" "'")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "/" "9")(re.union (re.range "=" "=")(re.union (re.range "?" "?") (re.range "A" "~")))))))))))) (re.++ (re.range "\u{22}" "\u{22}")(re.++ (re.* (re.union (re.union (re.range "\u{00}" "\u{09}")(re.union (re.range "\u{0b}" "\u{0c}")(re.union (re.range "\u{0e}" "!")(re.union (re.range "#" "[") (re.range "]" "\u{ff}"))))) (re.++ (re.range "\u{5c}" "\u{5c}") (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))))) (re.range "\u{22}" "\u{22}"))))(re.++ (re.range "@" "@") (re.union (re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.opt (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (re.* (re.++ (re.range "." ".")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.opt (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))))))) (re.++ (re.range "[" "[")(re.++ (re.* (re.union (re.union (re.range "\u{00}" "\u{09}")(re.union (re.range "\u{0b}" "\u{0c}")(re.union (re.range "\u{0e}" "Z") (re.range "^" "\u{ff}")))) (re.++ (re.range "\u{5c}" "\u{5c}") (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))))) (re.range "]" "]"))))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
