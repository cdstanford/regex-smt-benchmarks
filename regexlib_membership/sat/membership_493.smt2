;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((1[01])|(\d)):[0-5]\d(:[0-5]\d)?\s?([apAP][Mm])?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "8:19"
(define-fun Witness1 () String (seq.++ "8" (seq.++ ":" (seq.++ "1" (seq.++ "9" "")))))
;witness2: "6:38:46 Am"
(define-fun Witness2 () String (seq.++ "6" (seq.++ ":" (seq.++ "3" (seq.++ "8" (seq.++ ":" (seq.++ "4" (seq.++ "6" (seq.++ " " (seq.++ "A" (seq.++ "m" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "1" "1") (re.range "0" "1")) (re.range "0" "9"))(re.++ (re.range ":" ":")(re.++ (re.range "0" "5")(re.++ (re.range "0" "9")(re.++ (re.opt (re.++ (re.range ":" ":")(re.++ (re.range "0" "5") (re.range "0" "9"))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.++ (re.union (re.range "A" "A")(re.union (re.range "P" "P")(re.union (re.range "a" "a") (re.range "p" "p")))) (re.union (re.range "M" "M") (re.range "m" "m")))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
