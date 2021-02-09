;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([a-zA-Z]:(\\w+)*\\[a-zA-Z0_9]+)?.xls
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "v:\0\u00F9xls\xE"
(define-fun Witness1 () String (seq.++ "v" (seq.++ ":" (seq.++ "\x5c" (seq.++ "0" (seq.++ "\xf9" (seq.++ "x" (seq.++ "l" (seq.++ "s" (seq.++ "\x0e" ""))))))))))
;witness2: "\u0091xls"
(define-fun Witness2 () String (seq.++ "\x91" (seq.++ "x" (seq.++ "l" (seq.++ "s" "")))))

(assert (= regexA (re.++ (re.opt (re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.range ":" ":")(re.++ (re.* (re.++ (re.range "\x5c" "\x5c") (re.+ (re.range "w" "w"))))(re.++ (re.range "\x5c" "\x5c") (re.+ (re.union (re.range "0" "0")(re.union (re.range "9" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))))))))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) (str.to_re (seq.++ "x" (seq.++ "l" (seq.++ "s" ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
