;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (.*\.([wW][mM][aA])|([mM][pP][3])$)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00DD\u00D1.wmAx"
(define-fun Witness1 () String (seq.++ "\xdd" (seq.++ "\xd1" (seq.++ "." (seq.++ "w" (seq.++ "m" (seq.++ "A" (seq.++ "x" ""))))))))
;witness2: "Mp3"
(define-fun Witness2 () String (seq.++ "M" (seq.++ "p" (seq.++ "3" ""))))

(assert (= regexA (re.union (re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.range "." ".") (re.++ (re.union (re.range "W" "W") (re.range "w" "w"))(re.++ (re.union (re.range "M" "M") (re.range "m" "m")) (re.union (re.range "A" "A") (re.range "a" "a")))))) (re.++ (re.++ (re.union (re.range "M" "M") (re.range "m" "m"))(re.++ (re.union (re.range "P" "P") (re.range "p" "p")) (re.range "3" "3"))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
