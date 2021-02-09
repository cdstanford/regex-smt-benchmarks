;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((0[1-9])|(1[0-2]))\/(\d{4})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "09/9931"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "9" (seq.++ "/" (seq.++ "9" (seq.++ "9" (seq.++ "3" (seq.++ "1" ""))))))))
;witness2: "12/5927"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "2" (seq.++ "/" (seq.++ "5" (seq.++ "9" (seq.++ "2" (seq.++ "7" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.range "/" "/")(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
