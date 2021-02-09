;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-1]?[0-9]{1}/[0-3]?[0-9]{1}/20[0-9]{2})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "3/8/2099"
(define-fun Witness1 () String (seq.++ "3" (seq.++ "/" (seq.++ "8" (seq.++ "/" (seq.++ "2" (seq.++ "0" (seq.++ "9" (seq.++ "9" "")))))))))
;witness2: "18/32/2081"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "8" (seq.++ "/" (seq.++ "3" (seq.++ "2" (seq.++ "/" (seq.++ "2" (seq.++ "0" (seq.++ "8" (seq.++ "1" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.opt (re.range "0" "1"))(re.++ (re.range "0" "9")(re.++ (re.range "/" "/")(re.++ (re.opt (re.range "0" "3"))(re.++ (re.range "0" "9")(re.++ (str.to_re (seq.++ "/" (seq.++ "2" (seq.++ "0" "")))) ((_ re.loop 2 2) (re.range "0" "9")))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
