;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([0-9]+)\s(d)\s(([0-1][0-9])|([2][0-3])):([0-5][0-9]):([0-5][0-9])
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00D3\u00F7V85\xDd\xD09:54:15"
(define-fun Witness1 () String (seq.++ "\xd3" (seq.++ "\xf7" (seq.++ "V" (seq.++ "8" (seq.++ "5" (seq.++ "\x0d" (seq.++ "d" (seq.++ "\x0d" (seq.++ "0" (seq.++ "9" (seq.++ ":" (seq.++ "5" (seq.++ "4" (seq.++ ":" (seq.++ "1" (seq.++ "5" "")))))))))))))))))
;witness2: "\u00E7\u00CB\u0087\u00A38\u0085d\u008523:43:07CC"
(define-fun Witness2 () String (seq.++ "\xe7" (seq.++ "\xcb" (seq.++ "\x87" (seq.++ "\xa3" (seq.++ "8" (seq.++ "\x85" (seq.++ "d" (seq.++ "\x85" (seq.++ "2" (seq.++ "3" (seq.++ ":" (seq.++ "4" (seq.++ "3" (seq.++ ":" (seq.++ "0" (seq.++ "7" (seq.++ "C" (seq.++ "C" "")))))))))))))))))))

(assert (= regexA (re.++ (re.+ (re.range "0" "9"))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (re.range "d" "d")(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (re.union (re.++ (re.range "0" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3")))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.range ":" ":") (re.++ (re.range "0" "5") (re.range "0" "9"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
