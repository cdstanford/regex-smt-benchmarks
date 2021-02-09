;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^.*[_A-Za-z0-9]+[\t ]+[\*&]?[\t ]*[_A-Za-z0-9](::)?[_A-Za-z0-9:]+[\t ]*\(( *[ \[\]\*&A-Za-z0-9_]+ *,? *)*\).*$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "4YXQ 6L_()\u00D6"
(define-fun Witness1 () String (seq.++ "4" (seq.++ "Y" (seq.++ "X" (seq.++ "Q" (seq.++ " " (seq.++ "6" (seq.++ "L" (seq.++ "_" (seq.++ "(" (seq.++ ")" (seq.++ "\xd6" ""))))))))))))
;witness2: "\u00C1a *\x99y5  ( 6zIS)"
(define-fun Witness2 () String (seq.++ "\xc1" (seq.++ "a" (seq.++ " " (seq.++ "*" (seq.++ "\x09" (seq.++ "9" (seq.++ "y" (seq.++ "5" (seq.++ " " (seq.++ " " (seq.++ "(" (seq.++ " " (seq.++ "6" (seq.++ "z" (seq.++ "I" (seq.++ "S" (seq.++ ")" ""))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))(re.++ (re.+ (re.union (re.range "\x09" "\x09") (re.range " " " ")))(re.++ (re.opt (re.union (re.range "&" "&") (re.range "*" "*")))(re.++ (re.* (re.union (re.range "\x09" "\x09") (re.range " " " ")))(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))(re.++ (re.opt (str.to_re (seq.++ ":" (seq.++ ":" ""))))(re.++ (re.+ (re.union (re.range "0" ":")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))(re.++ (re.* (re.union (re.range "\x09" "\x09") (re.range " " " ")))(re.++ (re.range "(" "(")(re.++ (re.* (re.++ (re.* (re.range " " " "))(re.++ (re.+ (re.union (re.range " " " ")(re.union (re.range "&" "&")(re.union (re.range "*" "*")(re.union (re.range "0" "9")(re.union (re.range "A" "[")(re.union (re.range "]" "]")(re.union (re.range "_" "_") (re.range "a" "z")))))))))(re.++ (re.* (re.range " " " "))(re.++ (re.opt (re.range "," ",")) (re.* (re.range " " " ")))))))(re.++ (re.range ")" ")")(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (str.to_re "")))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
