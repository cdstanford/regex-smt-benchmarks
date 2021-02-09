;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([0-9]{1,2}[:][0-9]{1,2}[:]{0,2}[0-9]{0,2}[\s]{0,}[AMPamp]{0,2})
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "9:31::5\u00EA"
(define-fun Witness1 () String (seq.++ "9" (seq.++ ":" (seq.++ "3" (seq.++ "1" (seq.++ ":" (seq.++ ":" (seq.++ "5" (seq.++ "\xea" "")))))))))
;witness2: "88:4\u0085\xC \u00A0apD\x8S\u0093\u00CB"
(define-fun Witness2 () String (seq.++ "8" (seq.++ "8" (seq.++ ":" (seq.++ "4" (seq.++ "\x85" (seq.++ "\x0c" (seq.++ " " (seq.++ "\xa0" (seq.++ "a" (seq.++ "p" (seq.++ "D" (seq.++ "\x08" (seq.++ "S" (seq.++ "\x93" (seq.++ "\xcb" ""))))))))))))))))

(assert (= regexA (re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.range ":" ":")(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ ((_ re.loop 0 2) (re.range ":" ":"))(re.++ ((_ re.loop 0 2) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) ((_ re.loop 0 2) (re.union (re.range "A" "A")(re.union (re.range "M" "M")(re.union (re.range "P" "P")(re.union (re.range "a" "a")(re.union (re.range "m" "m") (re.range "p" "p")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
