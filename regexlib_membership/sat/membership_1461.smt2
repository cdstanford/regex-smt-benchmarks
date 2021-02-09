;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^\d{2}\.\d{3}\.\d{3}\/\d{4}\-\d{2}$)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "80.983.223/4884-46"
(define-fun Witness1 () String (seq.++ "8" (seq.++ "0" (seq.++ "." (seq.++ "9" (seq.++ "8" (seq.++ "3" (seq.++ "." (seq.++ "2" (seq.++ "2" (seq.++ "3" (seq.++ "/" (seq.++ "4" (seq.++ "8" (seq.++ "8" (seq.++ "4" (seq.++ "-" (seq.++ "4" (seq.++ "6" "")))))))))))))))))))
;witness2: "09.488.992/5838-27"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "9" (seq.++ "." (seq.++ "4" (seq.++ "8" (seq.++ "8" (seq.++ "." (seq.++ "9" (seq.++ "9" (seq.++ "2" (seq.++ "/" (seq.++ "5" (seq.++ "8" (seq.++ "3" (seq.++ "8" (seq.++ "-" (seq.++ "2" (seq.++ "7" "")))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "/" "/")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re "")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
