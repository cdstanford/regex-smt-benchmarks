;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = @[a-z0-9][a-z0-9-]*[a-z0-9](?:\.[a-z0-9][a-z0-9-]*[a-z0-9])+(?:,@[a-z0-9][a-z0-9-]*[a-z0-9](?:\.[a-z0-9][a-z0-9-]*[a-z0-9])+)*
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00D5\'@z9.36"
(define-fun Witness1 () String (seq.++ "\xd5" (seq.++ "'" (seq.++ "@" (seq.++ "z" (seq.++ "9" (seq.++ "." (seq.++ "3" (seq.++ "6" "")))))))))
;witness2: "\u00DDU@px.97i.z9.on"
(define-fun Witness2 () String (seq.++ "\xdd" (seq.++ "U" (seq.++ "@" (seq.++ "p" (seq.++ "x" (seq.++ "." (seq.++ "9" (seq.++ "7" (seq.++ "i" (seq.++ "." (seq.++ "z" (seq.++ "9" (seq.++ "." (seq.++ "o" (seq.++ "n" ""))))))))))))))))

(assert (= regexA (re.++ (re.range "@" "@")(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z"))))(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.+ (re.++ (re.range "." ".")(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z")))) (re.union (re.range "0" "9") (re.range "a" "z")))))) (re.* (re.++ (str.to_re (seq.++ "," (seq.++ "@" "")))(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z"))))(re.++ (re.union (re.range "0" "9") (re.range "a" "z")) (re.+ (re.++ (re.range "." ".")(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z")))) (re.union (re.range "0" "9") (re.range "a" "z"))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
