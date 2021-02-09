;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(CY){0,1}[0-9]{8}[A-Z]$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "CY81367419N"
(define-fun Witness1 () String (seq.++ "C" (seq.++ "Y" (seq.++ "8" (seq.++ "1" (seq.++ "3" (seq.++ "6" (seq.++ "7" (seq.++ "4" (seq.++ "1" (seq.++ "9" (seq.++ "N" ""))))))))))))
;witness2: "19485996Z"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "9" (seq.++ "4" (seq.++ "8" (seq.++ "5" (seq.++ "9" (seq.++ "9" (seq.++ "6" (seq.++ "Z" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (str.to_re (seq.++ "C" (seq.++ "Y" ""))))(re.++ ((_ re.loop 8 8) (re.range "0" "9"))(re.++ (re.range "A" "Z") (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
