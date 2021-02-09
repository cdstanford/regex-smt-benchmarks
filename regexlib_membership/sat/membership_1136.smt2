;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(4915[0-1]|491[0-4]\d|490\d\d|4[0-8]\d{3}|[1-3]\d{4}|[1-9]\d{0,3}|0)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "49118"
(define-fun Witness1 () String (seq.++ "4" (seq.++ "9" (seq.++ "1" (seq.++ "1" (seq.++ "8" ""))))))
;witness2: "1"
(define-fun Witness2 () String (seq.++ "1" ""))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (str.to_re (seq.++ "4" (seq.++ "9" (seq.++ "1" (seq.++ "5" ""))))) (re.range "0" "1"))(re.union (re.++ (str.to_re (seq.++ "4" (seq.++ "9" (seq.++ "1" ""))))(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (str.to_re (seq.++ "4" (seq.++ "9" (seq.++ "0" ""))))(re.++ (re.range "0" "9") (re.range "0" "9")))(re.union (re.++ (re.range "4" "4")(re.++ (re.range "0" "8") ((_ re.loop 3 3) (re.range "0" "9"))))(re.union (re.++ (re.range "1" "3") ((_ re.loop 4 4) (re.range "0" "9")))(re.union (re.++ (re.range "1" "9") ((_ re.loop 0 3) (re.range "0" "9"))) (re.range "0" "0"))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
