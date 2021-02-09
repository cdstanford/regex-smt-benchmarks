;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(6553[0-5]|655[0-2]\d|65[0-4]\d\d|6[0-4]\d{3}|[1-5]\d{4}|[1-9]\d{0,3}|0)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "0"
(define-fun Witness1 () String (seq.++ "0" ""))
;witness2: "65389"
(define-fun Witness2 () String (seq.++ "6" (seq.++ "5" (seq.++ "3" (seq.++ "8" (seq.++ "9" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (str.to_re (seq.++ "6" (seq.++ "5" (seq.++ "5" (seq.++ "3" ""))))) (re.range "0" "5"))(re.union (re.++ (str.to_re (seq.++ "6" (seq.++ "5" (seq.++ "5" ""))))(re.++ (re.range "0" "2") (re.range "0" "9")))(re.union (re.++ (str.to_re (seq.++ "6" (seq.++ "5" "")))(re.++ (re.range "0" "4")(re.++ (re.range "0" "9") (re.range "0" "9"))))(re.union (re.++ (re.range "6" "6")(re.++ (re.range "0" "4") ((_ re.loop 3 3) (re.range "0" "9"))))(re.union (re.++ (re.range "1" "5") ((_ re.loop 4 4) (re.range "0" "9")))(re.union (re.++ (re.range "1" "9") ((_ re.loop 0 3) (re.range "0" "9"))) (re.range "0" "0"))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
