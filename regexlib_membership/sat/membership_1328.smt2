;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-9A-Fa-f]{1,4}:){7}[0-9A-Fa-f]{1,4}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "81F3:ba:fB8:0:bCfe:c:1c9:4"
(define-fun Witness1 () String (str.++ "8" (str.++ "1" (str.++ "F" (str.++ "3" (str.++ ":" (str.++ "b" (str.++ "a" (str.++ ":" (str.++ "f" (str.++ "B" (str.++ "8" (str.++ ":" (str.++ "0" (str.++ ":" (str.++ "b" (str.++ "C" (str.++ "f" (str.++ "e" (str.++ ":" (str.++ "c" (str.++ ":" (str.++ "1" (str.++ "c" (str.++ "9" (str.++ ":" (str.++ "4" "")))))))))))))))))))))))))))
;witness2: "a:D:C28:f4:9:EF0:82a:A"
(define-fun Witness2 () String (str.++ "a" (str.++ ":" (str.++ "D" (str.++ ":" (str.++ "C" (str.++ "2" (str.++ "8" (str.++ ":" (str.++ "f" (str.++ "4" (str.++ ":" (str.++ "9" (str.++ ":" (str.++ "E" (str.++ "F" (str.++ "0" (str.++ ":" (str.++ "8" (str.++ "2" (str.++ "a" (str.++ ":" (str.++ "A" "")))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 7 7) (re.++ ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (re.range ":" ":")))(re.++ ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
