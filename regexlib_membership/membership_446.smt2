;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^.*[_A-Za-z0-9]+[\t ]+[\*&]?[\t ]*[_A-Za-z0-9](::)?[_A-Za-z0-9:]+[\t ]*\(( *[ \[\]\*&A-Za-z0-9_]+ *,? *)*\).*$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "4YXQ 6L_()\u00D6"
(define-fun Witness1 () String (str.++ "4" (str.++ "Y" (str.++ "X" (str.++ "Q" (str.++ " " (str.++ "6" (str.++ "L" (str.++ "_" (str.++ "(" (str.++ ")" (str.++ "\u{d6}" ""))))))))))))
;witness2: "\u00C1a *\x99y5  ( 6zIS)"
(define-fun Witness2 () String (str.++ "\u{c1}" (str.++ "a" (str.++ " " (str.++ "*" (str.++ "\u{09}" (str.++ "9" (str.++ "y" (str.++ "5" (str.++ " " (str.++ " " (str.++ "(" (str.++ " " (str.++ "6" (str.++ "z" (str.++ "I" (str.++ "S" (str.++ ")" ""))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{09}") (re.range " " " ")))(re.++ (re.opt (re.union (re.range "&" "&") (re.range "*" "*")))(re.++ (re.* (re.union (re.range "\u{09}" "\u{09}") (re.range " " " ")))(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))(re.++ (re.opt (str.to_re (str.++ ":" (str.++ ":" ""))))(re.++ (re.+ (re.union (re.range "0" ":")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{09}") (re.range " " " ")))(re.++ (re.range "(" "(")(re.++ (re.* (re.++ (re.* (re.range " " " "))(re.++ (re.+ (re.union (re.range " " " ")(re.union (re.range "&" "&")(re.union (re.range "*" "*")(re.union (re.range "0" "9")(re.union (re.range "A" "[")(re.union (re.range "]" "]")(re.union (re.range "_" "_") (re.range "a" "z")))))))))(re.++ (re.* (re.range " " " "))(re.++ (re.opt (re.range "," ",")) (re.* (re.range " " " ")))))))(re.++ (re.range ")" ")")(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (str.to_re "")))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
