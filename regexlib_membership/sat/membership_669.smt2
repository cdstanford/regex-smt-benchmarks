;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-ZÄÖÜ]{1,3}\-[ ]{0,1}[A-Z]{0,2}[0-9]{1,4}[H]{0,1}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00C4-33H"
(define-fun Witness1 () String (seq.++ "\xc4" (seq.++ "-" (seq.++ "3" (seq.++ "3" (seq.++ "H" ""))))))
;witness2: "\u00C4-J99H\u00B3"
(define-fun Witness2 () String (seq.++ "\xc4" (seq.++ "-" (seq.++ "J" (seq.++ "9" (seq.++ "9" (seq.++ "H" (seq.++ "\xb3" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 1 3) (re.union (re.range "A" "Z")(re.union (re.range "\xc4" "\xc4")(re.union (re.range "\xd6" "\xd6") (re.range "\xdc" "\xdc")))))(re.++ (re.range "-" "-")(re.++ (re.opt (re.range " " " "))(re.++ ((_ re.loop 0 2) (re.range "A" "Z"))(re.++ ((_ re.loop 1 4) (re.range "0" "9")) (re.opt (re.range "H" "H"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
