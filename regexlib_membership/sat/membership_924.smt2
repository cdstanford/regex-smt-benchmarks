;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-zA-Z]([a-zA-Z[._][\d]])*[@][a-zA-Z[.][\d]]*[.][a-z[.][\d]]*
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "R.4]@R5]..8"
(define-fun Witness1 () String (seq.++ "R" (seq.++ "." (seq.++ "4" (seq.++ "]" (seq.++ "@" (seq.++ "R" (seq.++ "5" (seq.++ "]" (seq.++ "." (seq.++ "." (seq.++ "8" ""))))))))))))
;witness2: "z@F3]..9]]\u00A7b\u0095"
(define-fun Witness2 () String (seq.++ "z" (seq.++ "@" (seq.++ "F" (seq.++ "3" (seq.++ "]" (seq.++ "." (seq.++ "." (seq.++ "9" (seq.++ "]" (seq.++ "]" (seq.++ "\xa7" (seq.++ "b" (seq.++ "\x95" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.* (re.++ (re.union (re.range "." ".")(re.union (re.range "A" "[")(re.union (re.range "_" "_") (re.range "a" "z"))))(re.++ (re.range "0" "9") (re.range "]" "]"))))(re.++ (re.range "@" "@")(re.++ (re.union (re.range "." ".")(re.union (re.range "A" "[") (re.range "a" "z")))(re.++ (re.range "0" "9")(re.++ (re.* (re.range "]" "]"))(re.++ (re.range "." ".")(re.++ (re.union (re.range "." ".")(re.union (re.range "[" "[") (re.range "a" "z")))(re.++ (re.range "0" "9") (re.* (re.range "]" "]"))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
