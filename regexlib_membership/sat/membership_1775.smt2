;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-Z]\:|\\)\\([^\\]+\\)*[^\/:*?"<>|]+\.htm(l)?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\\\u00D4\\u00B1\[\x1A\\u0090.htm"
(define-fun Witness1 () String (seq.++ "\x5c" (seq.++ "\x5c" (seq.++ "\xd4" (seq.++ "\x5c" (seq.++ "\xb1" (seq.++ "\x5c" (seq.++ "[" (seq.++ "\x1a" (seq.++ "\x5c" (seq.++ "\x90" (seq.++ "." (seq.++ "h" (seq.++ "t" (seq.++ "m" "")))))))))))))))
;witness2: "\\\u00A4\u00AB\\u00E3P.htm"
(define-fun Witness2 () String (seq.++ "\x5c" (seq.++ "\x5c" (seq.++ "\xa4" (seq.++ "\xab" (seq.++ "\x5c" (seq.++ "\xe3" (seq.++ "P" (seq.++ "." (seq.++ "h" (seq.++ "t" (seq.++ "m" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.range ":" ":")) (re.range "\x5c" "\x5c"))(re.++ (re.range "\x5c" "\x5c")(re.++ (re.* (re.++ (re.+ (re.union (re.range "\x00" "[") (re.range "]" "\xff"))) (re.range "\x5c" "\x5c")))(re.++ (re.+ (re.union (re.range "\x00" "!")(re.union (re.range "#" ")")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "{") (re.range "}" "\xff")))))))))(re.++ (str.to_re (seq.++ "." (seq.++ "h" (seq.++ "t" (seq.++ "m" "")))))(re.++ (re.opt (re.range "l" "l")) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
