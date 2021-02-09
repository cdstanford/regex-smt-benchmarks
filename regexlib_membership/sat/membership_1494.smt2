;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\+44\s?7\d{3}|\(?07\d{3}\)?)\s?\d{3}\s?\d{3}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "(07889\u0085499996"
(define-fun Witness1 () String (seq.++ "(" (seq.++ "0" (seq.++ "7" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "\x85" (seq.++ "4" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "6" ""))))))))))))))
;witness2: "(07298)819049"
(define-fun Witness2 () String (seq.++ "(" (seq.++ "0" (seq.++ "7" (seq.++ "2" (seq.++ "9" (seq.++ "8" (seq.++ ")" (seq.++ "8" (seq.++ "1" (seq.++ "9" (seq.++ "0" (seq.++ "4" (seq.++ "9" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (str.to_re (seq.++ "+" (seq.++ "4" (seq.++ "4" ""))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.range "7" "7") ((_ re.loop 3 3) (re.range "0" "9"))))) (re.++ (re.opt (re.range "(" "("))(re.++ (str.to_re (seq.++ "0" (seq.++ "7" "")))(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.opt (re.range ")" ")"))))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
