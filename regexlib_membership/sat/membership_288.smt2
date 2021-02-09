;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([\.\"\'-/ \(/)\s\[\]\\\,\<\>\;\:\{\}]?)([0-9]{3})([\.\"\'-/\(/)\s\[\]\\\,\<\>\;\:\{\}]?)([0-9]{3})([\,\.\"\'-/\(/)\s\[\]\\\<\>\;\:\{\}]?)([0-9]{4})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "696880\u00858849"
(define-fun Witness1 () String (seq.++ "6" (seq.++ "9" (seq.++ "6" (seq.++ "8" (seq.++ "8" (seq.++ "0" (seq.++ "\x85" (seq.++ "8" (seq.++ "8" (seq.++ "4" (seq.++ "9" ""))))))))))))
;witness2: "\u0085989\u00858889356"
(define-fun Witness2 () String (seq.++ "\x85" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "\x85" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "3" (seq.++ "5" (seq.++ "6" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x22" "\x22")(re.union (re.range "'" "/")(re.union (re.range ":" "<")(re.union (re.range ">" ">")(re.union (re.range "[" "]")(re.union (re.range "{" "{")(re.union (re.range "}" "}")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))))))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x22" "\x22")(re.union (re.range "'" "/")(re.union (re.range ":" "<")(re.union (re.range ">" ">")(re.union (re.range "[" "]")(re.union (re.range "{" "{")(re.union (re.range "}" "}")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))))))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x22" "\x22")(re.union (re.range "'" "/")(re.union (re.range ":" "<")(re.union (re.range ">" ">")(re.union (re.range "[" "]")(re.union (re.range "{" "{")(re.union (re.range "}" "}")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))))))))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
