;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\d{3}\s?\d{3}\s?\d{3}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "899829897"
(define-fun Witness1 () String (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "2" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "7" ""))))))))))
;witness2: "184\u00A0069 836"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "8" (seq.++ "4" (seq.++ "\xa0" (seq.++ "0" (seq.++ "6" (seq.++ "9" (seq.++ " " (seq.++ "8" (seq.++ "3" (seq.++ "6" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
