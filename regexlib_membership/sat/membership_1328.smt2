;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-9A-Fa-f]{1,4}:){7}[0-9A-Fa-f]{1,4}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "81F3:ba:fB8:0:bCfe:c:1c9:4"
(define-fun Witness1 () String (seq.++ "8" (seq.++ "1" (seq.++ "F" (seq.++ "3" (seq.++ ":" (seq.++ "b" (seq.++ "a" (seq.++ ":" (seq.++ "f" (seq.++ "B" (seq.++ "8" (seq.++ ":" (seq.++ "0" (seq.++ ":" (seq.++ "b" (seq.++ "C" (seq.++ "f" (seq.++ "e" (seq.++ ":" (seq.++ "c" (seq.++ ":" (seq.++ "1" (seq.++ "c" (seq.++ "9" (seq.++ ":" (seq.++ "4" "")))))))))))))))))))))))))))
;witness2: "a:D:C28:f4:9:EF0:82a:A"
(define-fun Witness2 () String (seq.++ "a" (seq.++ ":" (seq.++ "D" (seq.++ ":" (seq.++ "C" (seq.++ "2" (seq.++ "8" (seq.++ ":" (seq.++ "f" (seq.++ "4" (seq.++ ":" (seq.++ "9" (seq.++ ":" (seq.++ "E" (seq.++ "F" (seq.++ "0" (seq.++ ":" (seq.++ "8" (seq.++ "2" (seq.++ "a" (seq.++ ":" (seq.++ "A" "")))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 7 7) (re.++ ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (re.range ":" ":")))(re.++ ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
