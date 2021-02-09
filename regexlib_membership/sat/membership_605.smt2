;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([\r\n ]*//[^\r\n]*)+
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Y\xD  \xA//\u00D0\u00E7"
(define-fun Witness1 () String (seq.++ "Y" (seq.++ "\x0d" (seq.++ " " (seq.++ " " (seq.++ "\x0a" (seq.++ "/" (seq.++ "/" (seq.++ "\xd0" (seq.++ "\xe7" ""))))))))))
;witness2: "//\u00FFA"
(define-fun Witness2 () String (seq.++ "/" (seq.++ "/" (seq.++ "\xff" (seq.++ "A" "")))))

(assert (= regexA (re.+ (re.++ (re.* (re.union (re.range "\x0a" "\x0a")(re.union (re.range "\x0d" "\x0d") (re.range " " " "))))(re.++ (str.to_re (seq.++ "/" (seq.++ "/" ""))) (re.* (re.union (re.range "\x00" "\x09")(re.union (re.range "\x0b" "\x0c") (re.range "\x0e" "\xff")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
