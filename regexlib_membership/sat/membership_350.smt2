;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0]\d|[1][0-2]\/([0-2]\d|[3][0-1])\/([2][0]\d{2})\s([0-1]\d|[2][0-3])\:[0-5]\d\:[0-5]\d)?\s(AM|am|aM|Am|PM|pm|pM|Pm)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "09\u00A0AM"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "9" (seq.++ "\xa0" (seq.++ "A" (seq.++ "M" ""))))))
;witness2: "\x9AmR"
(define-fun Witness2 () String (seq.++ "\x09" (seq.++ "A" (seq.++ "m" (seq.++ "R" "")))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union (re.++ (re.range "0" "0") (re.range "0" "9")) (re.++ (re.range "1" "1")(re.++ (re.range "0" "2")(re.++ (re.range "/" "/")(re.++ (re.union (re.++ (re.range "0" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1")))(re.++ (re.range "/" "/")(re.++ (re.++ (str.to_re (seq.++ "2" (seq.++ "0" ""))) ((_ re.loop 2 2) (re.range "0" "9")))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (re.union (re.++ (re.range "0" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3")))(re.++ (re.range ":" ":")(re.++ (re.range "0" "5")(re.++ (re.range "0" "9")(re.++ (re.range ":" ":")(re.++ (re.range "0" "5") (re.range "0" "9"))))))))))))))))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))) (re.union (str.to_re (seq.++ "A" (seq.++ "M" "")))(re.union (str.to_re (seq.++ "a" (seq.++ "m" "")))(re.union (str.to_re (seq.++ "a" (seq.++ "M" "")))(re.union (str.to_re (seq.++ "A" (seq.++ "m" "")))(re.union (str.to_re (seq.++ "P" (seq.++ "M" "")))(re.union (str.to_re (seq.++ "p" (seq.++ "m" "")))(re.union (str.to_re (seq.++ "p" (seq.++ "M" ""))) (str.to_re (seq.++ "P" (seq.++ "m" "")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
