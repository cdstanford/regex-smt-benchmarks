;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = 0{3,}|1{3,}|2{3,}|3{3,}|4{3,}|5{3,}|6{3,}|7{3,}|8{3,}|9{3,}
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "^\u0097\u00F91111\x15"
(define-fun Witness1 () String (str.++ "^" (str.++ "\u{97}" (str.++ "\u{f9}" (str.++ "1" (str.++ "1" (str.++ "1" (str.++ "1" (str.++ "\u{15}" "")))))))))
;witness2: "888E"
(define-fun Witness2 () String (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "E" "")))))

(assert (= regexA (re.union (re.++ ((_ re.loop 3 3) (re.range "0" "0")) (re.* (re.range "0" "0")))(re.union (re.++ ((_ re.loop 3 3) (re.range "1" "1")) (re.* (re.range "1" "1")))(re.union (re.++ ((_ re.loop 3 3) (re.range "2" "2")) (re.* (re.range "2" "2")))(re.union (re.++ ((_ re.loop 3 3) (re.range "3" "3")) (re.* (re.range "3" "3")))(re.union (re.++ ((_ re.loop 3 3) (re.range "4" "4")) (re.* (re.range "4" "4")))(re.union (re.++ ((_ re.loop 3 3) (re.range "5" "5")) (re.* (re.range "5" "5")))(re.union (re.++ ((_ re.loop 3 3) (re.range "6" "6")) (re.* (re.range "6" "6")))(re.union (re.++ ((_ re.loop 3 3) (re.range "7" "7")) (re.* (re.range "7" "7")))(re.union (re.++ ((_ re.loop 3 3) (re.range "8" "8")) (re.* (re.range "8" "8"))) (re.++ ((_ re.loop 3 3) (re.range "9" "9")) (re.* (re.range "9" "9"))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
