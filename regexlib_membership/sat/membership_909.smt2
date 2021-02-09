;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ;?(?:(?:"((?:[^"]|"")*)")|([^;]*))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\x1C\"\"\u009E\u00EC\u00B3\u0092"
(define-fun Witness1 () String (seq.++ "\x1c" (seq.++ "\x22" (seq.++ "\x22" (seq.++ "\x9e" (seq.++ "\xec" (seq.++ "\xb3" (seq.++ "\x92" ""))))))))
;witness2: "\u00D5&1\u0085"
(define-fun Witness2 () String (seq.++ "\xd5" (seq.++ "&" (seq.++ "1" (seq.++ "\x85" "")))))

(assert (= regexA (re.++ (re.opt (re.range ";" ";")) (re.union (re.++ (re.range "\x22" "\x22")(re.++ (re.* (re.union (re.union (re.range "\x00" "!") (re.range "#" "\xff")) (str.to_re (seq.++ "\x22" (seq.++ "\x22" ""))))) (re.range "\x22" "\x22"))) (re.* (re.union (re.range "\x00" ":") (re.range "<" "\xff")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
