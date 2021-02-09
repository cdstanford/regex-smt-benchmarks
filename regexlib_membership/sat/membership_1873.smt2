;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((\(\d{3}\)?)|(\d{3}))([\s-./]?)(\d{3})([\s-./]?)(\d{4})
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "880\u008594929097#\xBE\x2\u00E2T\x7"
(define-fun Witness1 () String (seq.++ "8" (seq.++ "8" (seq.++ "0" (seq.++ "\x85" (seq.++ "9" (seq.++ "4" (seq.++ "9" (seq.++ "2" (seq.++ "9" (seq.++ "0" (seq.++ "9" (seq.++ "7" (seq.++ "#" (seq.++ "\x0b" (seq.++ "E" (seq.++ "\x02" (seq.++ "\xe2" (seq.++ "T" (seq.++ "\x07" ""))))))))))))))))))))
;witness2: "\u00EE9817390/0156\x9\u00D5bt\u00F2q\u00BB\u00B2\xB"
(define-fun Witness2 () String (seq.++ "\xee" (seq.++ "9" (seq.++ "8" (seq.++ "1" (seq.++ "7" (seq.++ "3" (seq.++ "9" (seq.++ "0" (seq.++ "/" (seq.++ "0" (seq.++ "1" (seq.++ "5" (seq.++ "6" (seq.++ "\x09" (seq.++ "\xd5" (seq.++ "b" (seq.++ "t" (seq.++ "\xf2" (seq.++ "q" (seq.++ "\xbb" (seq.++ "\xb2" (seq.++ "\x0b" "")))))))))))))))))))))))

(assert (= regexA (re.++ (re.union (re.++ (re.range "(" "(")(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.opt (re.range ")" ")")))) ((_ re.loop 3 3) (re.range "0" "9")))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "/")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "/")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))) ((_ re.loop 4 4) (re.range "0" "9"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
