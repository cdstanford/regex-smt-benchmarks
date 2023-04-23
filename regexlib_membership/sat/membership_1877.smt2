;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Z0-9]{8}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{12}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Z929UZ88-Q02G-82Z9-95IN-9BXAER589D7S"
(define-fun Witness1 () String (str.++ "Z" (str.++ "9" (str.++ "2" (str.++ "9" (str.++ "U" (str.++ "Z" (str.++ "8" (str.++ "8" (str.++ "-" (str.++ "Q" (str.++ "0" (str.++ "2" (str.++ "G" (str.++ "-" (str.++ "8" (str.++ "2" (str.++ "Z" (str.++ "9" (str.++ "-" (str.++ "9" (str.++ "5" (str.++ "I" (str.++ "N" (str.++ "-" (str.++ "9" (str.++ "B" (str.++ "X" (str.++ "A" (str.++ "E" (str.++ "R" (str.++ "5" (str.++ "8" (str.++ "9" (str.++ "D" (str.++ "7" (str.++ "S" "")))))))))))))))))))))))))))))))))))))
;witness2: "289JZ9N8-0Q4X-B93Q-P9OJ-MV28809Z0V48"
(define-fun Witness2 () String (str.++ "2" (str.++ "8" (str.++ "9" (str.++ "J" (str.++ "Z" (str.++ "9" (str.++ "N" (str.++ "8" (str.++ "-" (str.++ "0" (str.++ "Q" (str.++ "4" (str.++ "X" (str.++ "-" (str.++ "B" (str.++ "9" (str.++ "3" (str.++ "Q" (str.++ "-" (str.++ "P" (str.++ "9" (str.++ "O" (str.++ "J" (str.++ "-" (str.++ "M" (str.++ "V" (str.++ "2" (str.++ "8" (str.++ "8" (str.++ "0" (str.++ "9" (str.++ "Z" (str.++ "0" (str.++ "V" (str.++ "4" (str.++ "8" "")))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 8 8) (re.union (re.range "0" "9") (re.range "A" "Z")))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9") (re.range "A" "Z")))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9") (re.range "A" "Z")))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9") (re.range "A" "Z")))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 12 12) (re.union (re.range "0" "9") (re.range "A" "Z"))) (str.to_re "")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
