;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([^_.]([a-zA-Z0-9_]*[.]?[a-zA-Z0-9_]+[^_]){2})@([a-z0-9]+[.]([a-z]{2,3}|[a-z]{2,3}[.][a-z]{2,3}))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Z.99\u00D3.28x8\u00F6@z8.uya.zy\u00EA%"
(define-fun Witness1 () String (seq.++ "Z" (seq.++ "." (seq.++ "9" (seq.++ "9" (seq.++ "\xd3" (seq.++ "." (seq.++ "2" (seq.++ "8" (seq.++ "x" (seq.++ "8" (seq.++ "\xf6" (seq.++ "@" (seq.++ "z" (seq.++ "8" (seq.++ "." (seq.++ "u" (seq.++ "y" (seq.++ "a" (seq.++ "." (seq.++ "z" (seq.++ "y" (seq.++ "\xea" (seq.++ "%" ""))))))))))))))))))))))))
;witness2: "\x1Ct9\u00F3\xD8pe8\u008D@89.iyz"
(define-fun Witness2 () String (seq.++ "\x1c" (seq.++ "t" (seq.++ "9" (seq.++ "\xf3" (seq.++ "\x0d" (seq.++ "8" (seq.++ "p" (seq.++ "e" (seq.++ "8" (seq.++ "\x8d" (seq.++ "@" (seq.++ "8" (seq.++ "9" (seq.++ "." (seq.++ "i" (seq.++ "y" (seq.++ "z" ""))))))))))))))))))

(assert (= regexA (re.++ (re.++ (re.union (re.range "\x00" "-")(re.union (re.range "/" "^") (re.range "`" "\xff"))) ((_ re.loop 2 2) (re.++ (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))(re.++ (re.opt (re.range "." "."))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))) (re.union (re.range "\x00" "^") (re.range "`" "\xff")))))))(re.++ (re.range "@" "@") (re.++ (re.+ (re.union (re.range "0" "9") (re.range "a" "z")))(re.++ (re.range "." ".") (re.union ((_ re.loop 2 3) (re.range "a" "z")) (re.++ ((_ re.loop 2 3) (re.range "a" "z"))(re.++ (re.range "." ".") ((_ re.loop 2 3) (re.range "a" "z")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
