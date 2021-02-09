;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([A-Z]{1,2}[0-9]{1,2})|([A-Z]{1,2}[0-9][A-Z]))\s?([0-9][A-Z]{2})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "I789AB"
(define-fun Witness1 () String (seq.++ "I" (seq.++ "7" (seq.++ "8" (seq.++ "9" (seq.++ "A" (seq.++ "B" "")))))))
;witness2: "X91ZF"
(define-fun Witness2 () String (seq.++ "X" (seq.++ "9" (seq.++ "1" (seq.++ "Z" (seq.++ "F" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ ((_ re.loop 1 2) (re.range "A" "Z")) ((_ re.loop 1 2) (re.range "0" "9"))) (re.++ ((_ re.loop 1 2) (re.range "A" "Z"))(re.++ (re.range "0" "9") (re.range "A" "Z"))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.++ (re.range "0" "9") ((_ re.loop 2 2) (re.range "A" "Z"))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
