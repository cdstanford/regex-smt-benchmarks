;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((\d|[1-9]\d|2[0-4]\d|25[0-5]|1\d\d)(?:\.(\d|[1-9]\d|2[0-4]\d|25[0-5]|1\d\d)){3})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "254.252.227.130"
(define-fun Witness1 () String (seq.++ "2" (seq.++ "5" (seq.++ "4" (seq.++ "." (seq.++ "2" (seq.++ "5" (seq.++ "2" (seq.++ "." (seq.++ "2" (seq.++ "2" (seq.++ "7" (seq.++ "." (seq.++ "1" (seq.++ "3" (seq.++ "0" ""))))))))))))))))
;witness2: "198.42.253.43"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "9" (seq.++ "8" (seq.++ "." (seq.++ "4" (seq.++ "2" (seq.++ "." (seq.++ "2" (seq.++ "5" (seq.++ "3" (seq.++ "." (seq.++ "4" (seq.++ "3" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.union (re.range "0" "9")(re.union (re.++ (re.range "1" "9") (re.range "0" "9"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5")) (re.++ (re.range "1" "1")(re.++ (re.range "0" "9") (re.range "0" "9"))))))) ((_ re.loop 3 3) (re.++ (re.range "." ".") (re.union (re.range "0" "9")(re.union (re.++ (re.range "1" "9") (re.range "0" "9"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5")) (re.++ (re.range "1" "1")(re.++ (re.range "0" "9") (re.range "0" "9")))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
