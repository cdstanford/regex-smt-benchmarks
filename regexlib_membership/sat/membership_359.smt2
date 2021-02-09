;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\d{1}\.){0,1}\d{1,3}\,\d{2}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "2,88"
(define-fun Witness1 () String (seq.++ "2" (seq.++ "," (seq.++ "8" (seq.++ "8" "")))))
;witness2: "1.9,81"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "." (seq.++ "9" (seq.++ "," (seq.++ "8" (seq.++ "1" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.++ (re.range "0" "9") (re.range "." ".")))(re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.range "," ",")(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
