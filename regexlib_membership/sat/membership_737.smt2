;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^\d{1,3}$)|(\d{1,3})\.?(\d{0,0}[0,5])
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "75"
(define-fun Witness1 () String (seq.++ "7" (seq.++ "5" "")))
;witness2: "18.,"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "8" (seq.++ "." (seq.++ "," "")))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ ((_ re.loop 1 3) (re.range "0" "9")) (str.to_re ""))) (re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.opt (re.range "." ".")) (re.union (re.range "," ",")(re.union (re.range "0" "0") (re.range "5" "5"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
