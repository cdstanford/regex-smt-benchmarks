;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = /([^\x00-\xFF]\s*)/u
;---
(set-info :status unsat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

(assert (= regexA (re.++ (re.range "/" "/")(re.++ (re.++ re.none (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))) (str.to_re (seq.++ "/" (seq.++ "u" "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
(check-sat)
