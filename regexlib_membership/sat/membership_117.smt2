;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [A-Za-z0-9!#$%&'*+\-/=?^_`{|}~]+(?:\.[A-Za-z0-9!#$%&'*+\-/=?^_`{|}~]+)*@[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*(?:\.[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*)*
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "D\u00EAD6.vY#@H0352.N39aIk-0"
(define-fun Witness1 () String (seq.++ "D" (seq.++ "\xea" (seq.++ "D" (seq.++ "6" (seq.++ "." (seq.++ "v" (seq.++ "Y" (seq.++ "#" (seq.++ "@" (seq.++ "H" (seq.++ "0" (seq.++ "3" (seq.++ "5" (seq.++ "2" (seq.++ "." (seq.++ "N" (seq.++ "3" (seq.++ "9" (seq.++ "a" (seq.++ "I" (seq.++ "k" (seq.++ "-" (seq.++ "0" ""))))))))))))))))))))))))
;witness2: "1.^@99g"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "." (seq.++ "^" (seq.++ "@" (seq.++ "9" (seq.++ "9" (seq.++ "g" ""))))))))

(assert (= regexA (re.++ (re.+ (re.union (re.range "!" "!")(re.union (re.range "#" "'")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "/" "9")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z") (re.range "^" "~"))))))))))(re.++ (re.* (re.++ (re.range "." ".") (re.+ (re.union (re.range "!" "!")(re.union (re.range "#" "'")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "/" "9")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z") (re.range "^" "~"))))))))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.* (re.++ (re.range "-" "-") (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))) (re.* (re.++ (re.range "." ".")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (re.* (re.++ (re.range "-" "-") (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
