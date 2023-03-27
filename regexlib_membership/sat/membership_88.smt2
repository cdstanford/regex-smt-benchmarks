;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = @[a-z0-9][a-z0-9-]*[a-z0-9](?:\.[a-z0-9][a-z0-9-]*[a-z0-9])+(?:,@[a-z0-9][a-z0-9-]*[a-z0-9](?:\.[a-z0-9][a-z0-9-]*[a-z0-9])+)*
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00D5\'@z9.36"
(define-fun Witness1 () String (str.++ "\u{d5}" (str.++ "'" (str.++ "@" (str.++ "z" (str.++ "9" (str.++ "." (str.++ "3" (str.++ "6" "")))))))))
;witness2: "\u00DDU@px.97i.z9.on"
(define-fun Witness2 () String (str.++ "\u{dd}" (str.++ "U" (str.++ "@" (str.++ "p" (str.++ "x" (str.++ "." (str.++ "9" (str.++ "7" (str.++ "i" (str.++ "." (str.++ "z" (str.++ "9" (str.++ "." (str.++ "o" (str.++ "n" ""))))))))))))))))

(assert (= regexA (re.++ (re.range "@" "@")(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z"))))(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.+ (re.++ (re.range "." ".")(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z")))) (re.union (re.range "0" "9") (re.range "a" "z")))))) (re.* (re.++ (str.to_re (str.++ "," (str.++ "@" "")))(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z"))))(re.++ (re.union (re.range "0" "9") (re.range "a" "z")) (re.+ (re.++ (re.range "." ".")(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z")))) (re.union (re.range "0" "9") (re.range "a" "z"))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
