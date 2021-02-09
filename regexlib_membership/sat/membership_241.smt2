;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([1-9]{1}|[1-9]{1}[0-9]{1,3}|[1-5]{1}[0-9]{4}|6[0-4]{1}[0-9]{3}|65[0-4]{1}[0-9]{2}|655[0-2]{1}[0-9]{1}|6553[0-6]{1})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "62559"
(define-fun Witness1 () String (seq.++ "6" (seq.++ "2" (seq.++ "5" (seq.++ "5" (seq.++ "9" ""))))))
;witness2: "1"
(define-fun Witness2 () String (seq.++ "1" ""))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "1" "9")(re.union (re.++ (re.range "1" "9") ((_ re.loop 1 3) (re.range "0" "9")))(re.union (re.++ (re.range "1" "5") ((_ re.loop 4 4) (re.range "0" "9")))(re.union (re.++ (re.range "6" "6")(re.++ (re.range "0" "4") ((_ re.loop 3 3) (re.range "0" "9"))))(re.union (re.++ (str.to_re (seq.++ "6" (seq.++ "5" "")))(re.++ (re.range "0" "4") ((_ re.loop 2 2) (re.range "0" "9"))))(re.union (re.++ (str.to_re (seq.++ "6" (seq.++ "5" (seq.++ "5" ""))))(re.++ (re.range "0" "2") (re.range "0" "9"))) (re.++ (str.to_re (seq.++ "6" (seq.++ "5" (seq.++ "5" (seq.++ "3" ""))))) (re.range "0" "6")))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
