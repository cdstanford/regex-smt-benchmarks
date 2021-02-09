;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[1-9]{1}[0-9]{3}\s?[A-Z]{2}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "9329OX"
(define-fun Witness1 () String (seq.++ "9" (seq.++ "3" (seq.++ "2" (seq.++ "9" (seq.++ "O" (seq.++ "X" "")))))))
;witness2: "3828\u00A0KD"
(define-fun Witness2 () String (seq.++ "3" (seq.++ "8" (seq.++ "2" (seq.++ "8" (seq.++ "\xa0" (seq.++ "K" (seq.++ "D" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "1" "9")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 2 2) (re.range "A" "Z")) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
